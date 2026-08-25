//
//  GamesModel.swift
//  learn
//
//  Created by Cindy Michalowski on 8/21/26.
//

import Foundation

public class GamesModel {
    
    public static func getGames() -> [GameObject] {
            var games: [GameObject] = [GameObject]()
        games.append(GameObject(uniqueID: 1, name: "A WAY OUT", image: "ic-game-1", slug: .WayOut, timePlayed: "5h 6m", progress: "1%", medal: "None"))
            games.append(GameObject(uniqueID: 2, name: "FIFA 22", image: "ic-game-2", slug: .F22, timePlayed: "10h 24m", progress: "76%", medal: "Bronze"))
            games.append(GameObject(uniqueID: 3, name: "FARCRY V", image: "ic-game-3", slug: .FC5, timePlayed: "2h 36m", progress: "27%", medal: "Gold"))
            games.append(GameObject(uniqueID: 4, name: "CALL OF DUTY MW", image: "ic-game-4", slug: .CODMW, timePlayed: "0h 45m", progress: "19%", medal: "Silver"))
            games.append(GameObject(uniqueID: 5, name: "ASSASINS CREED VALHALLA", image: "ic-game-5", slug: .ACVH, timePlayed: "251h 39m", progress: "100%", medal: "Gold"))
            games.append(GameObject(uniqueID: 6, name: "BATTLEFIELD V", image: "ic-game-6", slug: .BF5, timePlayed: "14h 16m", progress: "84%", medal: "Bronze"))
            games.append(GameObject(uniqueID: 8, name: "BATMAN ARKHAM CITY", image: "ic-game-8", slug: .BATAC, timePlayed: "51h 6m", progress: "64%", medal: "Silver"))
            games.append(GameObject(uniqueID: 9, name: "CALL OF DUTY BLACKOPS", image: "ic-game-9", slug: .CODBO, timePlayed: "34h 1m", progress: "70%", medal: "Bronze"))
            games.append(GameObject(uniqueID: 10, name: "CRISIS II", image: "ic-game-10", slug: .C2, timePlayed: "6h 59m", progress: "59%", medal: "Silver"))
            games.append(GameObject(uniqueID: 11, name: "CALL OF DUTY BLACK OPS III", image: "ic-game-11", slug: .CODBO3, timePlayed: "21h 37m", progress: "3%", medal: "None"))
            return games
        }
}
