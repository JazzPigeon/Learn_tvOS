//
//  GameStructAndEnum.swift
//  learn
//
//  Created by Cindy Michalowski on 8/21/26.
//

import Foundation

struct GameObject: Hashable, Identifiable {
    var id: Int { uniqueID }
    var uniqueID : Int
    var name: String
    var image: String
    var slug: GameEnum
    var timePlayed: String
    var progress: String
    var medal: String
}

enum GameEnum {
    case WayOut
    case F22
    case FC5
    case CODMW
    case ACVH
    case BF5
    case AL
    case BATAC
    case CODBO3
    case C2
    case CODBO
}
