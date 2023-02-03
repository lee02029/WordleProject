//
//  KeyboardView.swift
//  Kotobaasobi
//
//  Created by Yoonjae on 2023/01/10.
//

import SwiftUI
import ComposableArchitecture

struct KeyboardButton: View {
    let key: KeyboardKey
    var body: some View {
        Group {
            switch key {
            case let .character(character, _):
                Text(String(character).uppercased())
                    .foregroundColor(.black)
                    .padding(.vertical)
                    .frame(width: 30, height: 30)
                    .background(key.backgroundColor)
                    .cornerRadius(4)
            case .symbol(let string):
                Image(systemName: string)
                    .foregroundColor(.black)
                    .padding(.vertical)
                    .frame(width: 70, height: 30)
                    .background(Color(hex: "ABB0BC"))
                    .cornerRadius(4)
            }
        }
        
    }
}

struct HardKeyboardView: View {
    
    let store: Store<HardGameState, HardGameAction>
    @ObservedObject var viewStore: ViewStore<HardGameState, HardGameAction>
    
    init(store: Store<HardGameState, HardGameAction>) {
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
