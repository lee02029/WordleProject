//
//  EasyGameView.swift
//  Kotobaasobi
//
//  Created by Yoonjae on 2023/01/28.
//

import SwiftUI
import ComposableArchitecture

struct EasyKeyboardView: View {
    let store: Store<EasyGameState, EasyGameAction>
    @ObservedObject var viewStore: ViewStore<EasyGameState, EasyGameAction>

    init(store: Store<EasyGameState, EasyGameAction>) {
        self.store = store
        self.viewStore = ViewStore(store)
    }

    var body: some View {
        ZStack {
            Color(hex: "DDDEE1")
                .edgesIgnoringSafeArea(.all)
                .opacity(0.6)
            WithViewStore(store) { viewStore in
                let rows = viewStore.keyboardKeys
                VStack {
                    ForEach(rows.indices, id:\.self) { row in
                        HStack {
                            ForEach(rows[row].indices, id:\.self) { col in
                                Button {
                                    viewStore.send(.keyboardInput(rows[row][col]))
                                } label: {
                                    KeyboardButton(key: rows[row][col])
                                        .font(.custom("MochiyPopOne-Regular", size: 16))
                                }
                            }
                        }
                    }
                }
            }
            .padding()
        }
    }
}

