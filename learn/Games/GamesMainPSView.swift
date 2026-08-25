//
//  GamesMainPSView.swift
//  learn
//
//  Created by Cindy Michalowski on 8/21/26.
//

import SwiftUI
import GameData

struct GamesMainPSView: View {
    
    var model = GamesModel()
    
    @FocusState var focusedField: GameObject?
    @State private var selectedGame: GameObject?
    
    var body: some View {
        VStack {
            ScrollView (.horizontal, showsIndicators: false) {
                LazyHStack {
                    ForEach(model.getGames(), id: \.uniqueID) { game in
                        Button {
                            selectedGame = game
                        } label: {
                            Image(game.image)
                                .resizable()
                                .frame(width: 270, height: 270)
                        }
                        .buttonStyle(.borderless)
                        .focused($focusedField, equals: game)
                    }
                }
            }
            .frame(height: 320)
            
            // Game Description
            HStack {
                VStack (alignment: .leading, spacing: 40) {
                    Text(focusedField?.name ?? "-")
                        .foregroundStyle(.white)
                        .bold()
                        .font(.title2)
                    HStack {
                        VStack (alignment: .leading, spacing: 8) {
                            Text("Time played")
                            Text(focusedField?.timePlayed ?? "0h 0m")
                        }
                        VStack (alignment: .leading, spacing: 8) {
                            Text("Progress")
                            Text(focusedField?.progress ?? "0%")
                        }
                        VStack (alignment: .leading, spacing: 8) {
                            Text("Last medal")
                            HStack (spacing: 12) {
                                Image(systemName: "medal.fill")
                                    .frame(width: 40, height: 40)
                                    
                                Text(focusedField?.medal ?? "None")
                            }
                        }
                    }
                }
                .padding(.leading, 40)
                Spacer()
            }
            .opacity(focusedField != nil ? 1 : 0)
            Spacer()
        }
        .frame(height: 600)
        .onAppear {
            focusedField = model.getGames().first
        }
        .fullScreenCover(item: $selectedGame) { game in
            GameDetailView(game: game)
        }
    }
}
