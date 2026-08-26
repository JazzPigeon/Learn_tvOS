#!/usr/bin/env python3
"""Render an .xcresult bundle as a Markdown report for a GitHub step summary."""

import json
import subprocess
import sys

ICONS = {
    "Passed": "🟢",
    "Failed": "🔴",
    "Skipped": "⚪️",
    "Expected Failure": "🟡",
}


def xcresulttool(subcommand, path):
    result = subprocess.run(
        ["xcrun", "xcresulttool", "get", "test-results", subcommand,
         "--path", path, "--format", "json"],
        capture_output=True,
        text=True,
    )
    if result.returncode != 0:
        return None
    return json.loads(result.stdout)


def collect_cases(nodes, trail=()):
    """Flatten the test tree into (suite path, case node) pairs."""
    for node in nodes:
        kind = node.get("nodeType")
        if kind == "Test Case":
            yield " / ".join(trail), node
        else:
            name = node.get("name")
            # The top-level "Test Plan" node repeats the scheme name, which adds
            # a level of nesting without telling the reader anything useful.
            next_trail = trail if kind == "Test Plan" else trail + (name,)
            yield from collect_cases(node.get("children", []), next_trail)


def failure_messages(case):
    return [child["name"] for child in case.get("children", [])
            if child.get("nodeType") == "Failure Message"]


def main():
    if len(sys.argv) < 2:
        print("usage: xcresult_summary.py <path-to-xcresult>", file=sys.stderr)
        return 2

    path = sys.argv[1]
    summary = xcresulttool("summary", path)
    if summary is None:
        print("## tvOS UI Tests\n")
        print("Could not read a test report from the result bundle. "
              "The build most likely failed before any tests ran — "
              "check the job log and the uploaded artifacts.")
        return 0

    out = ["## tvOS UI Tests", ""]

    overall = summary.get("result", "Unknown")
    passed = summary.get("passedTests", 0)
    failed = summary.get("failedTests", 0)
    skipped = summary.get("skippedTests", 0)
    duration = summary.get("finishTime", 0) - summary.get("startTime", 0)

    out.append(f"### {ICONS.get(overall, '❔')} {overall}")
    out.append("")
    out.append(f"**{passed} passed · {failed} failed · {skipped} skipped** "
               f"in {duration:.0f}s")
    out.append("")

    for entry in summary.get("devicesAndConfigurations", []):
        device = entry.get("device", {})
        out.append(f"Ran on {device.get('deviceName', 'unknown device')} · "
                   f"{device.get('platform', '')} {device.get('osVersion', '')} · "
                   f"{device.get('architecture', '')}")
        out.append("")

    failures = summary.get("testFailures", [])
    if failures:
        out.append("### Failures")
        out.append("")
        for failure in failures:
            out.append(f"**{failure.get('targetName', '')} / "
                       f"{failure.get('testName', 'unknown test')}**")
            out.append("")
            out.append("```")
            out.append(failure.get("failureText", "No failure message recorded."))
            out.append("```")
            out.append("")

    tests = xcresulttool("tests", path)
    if tests:
        out.append("### All tests")
        out.append("")
        out.append("| | Test | Duration |")
        out.append("| :-: | --- | --- |")
        for suite, case in collect_cases(tests.get("testNodes", [])):
            result = case.get("result", "Unknown")
            name = case.get("name", "unknown")
            label = f"{suite} / {name}" if suite else name
            out.append(f"| {ICONS.get(result, '❔')} | {label} | "
                       f"{case.get('duration', '—')} |")
        out.append("")

        detailed = [(suite, case)
                    for suite, case in collect_cases(tests.get("testNodes", []))
                    if failure_messages(case)]
        if detailed:
            out.append("<details><summary>Failure details</summary>")
            out.append("")
            for suite, case in detailed:
                out.append(f"**{suite} / {case.get('name')}**")
                out.append("")
                for message in failure_messages(case):
                    out.append(f"- {message}")
                out.append("")
            out.append("</details>")
            out.append("")

    print("\n".join(out))
    return 0


if __name__ == "__main__":
    sys.exit(main())
