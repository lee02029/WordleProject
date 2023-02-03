//
//  GameOverView.swift
//  Kotobaasobi
//
//  Created by Yoonjae on 2023/01/10.
//

import SwiftUI
import ComposableArchitecture

struct EasyGameOverView: View {
    let store: Store<EasyGameState, EasyGameAction>
    @ObservedObject var viewStore: ViewStore<EasyGameState, EasyGameAction>
    @Environment(\.presentationMode) var presentationMode
    init(store: Store<EasyGameState, EasyGameAction>) {
        self.store = store
        self.viewStore = ViewStore(store)
    }
    
    var titleText: String {
        switch viewStore.gameState {
        case let .gameOver(didWin: didWin):
            return didWin ? "Correct!" : "Game Over"
        default:
            return ""
        }
    }
    
    var body: some View {
        VStack {
            Spacer().frame(height:40)
            if viewStore.gameState == .gameOver(didWin: true) {
                Text("正解です")
                    .font(.custom("MochiyPopOne-Regular", size: 32))
                Spacer().frame(height:40)
                Button() {
                    viewStore.send(.newGame)
                } label: {
                    Text("新しいゲーム")
                        .font(.custom("MochiyPopOne-Regular", size: 16))
                        .padding(.vertical, 2)
                        .padding(.horizontal,40)
                }
                .buttonStyle(.borderedProminent)
                .cornerRadius(2)
                
            } else {
                Text("残念です")
                    .font(.custom("MochiyPopOne-Regular", size: 32))
                Spacer().frame(height:40)
                Button() {
                    viewStore.send(.failGame)
                }label: {
                    Text("もう１回")
                        .font(.custom("MochiyPopOne-Regular", size: 16))
                        .padding(.vertical, 2)
                        .padding(.horizontal,40)
                }
                .buttonStyle(.borderedProminent)
                .cornerRadius(2)
            }
            Spacer().frame(height:40)
        }
        .foregroundColor(.black)
        .padding()
    }
}
