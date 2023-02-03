//
//  HardGameView.swift
//  Kotobaasobi
//
//  Created by Yoonjae on 2023/01/28.
//

import SwiftUI
import ComposableArchitecture
import AlertX

struct HardGameView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var infoAlert: Bool = false
    let store: Store<HardGameState, HardGameAction>
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(hex: "ECE4D2")
                    .edgesIgnoringSafeArea(.all)
                
                WithViewStore(store) { viewStore in
                    VStack {
                        HardBoardView(store: self.store)
                            .layoutPriority(1)
                        switch viewStore.gameState {
                        case .playing:
                            HardKeyboardView(store: self.store)
                        case .gameOver:
                            HardGameOverView(store: self.store)
                        }
                    }
                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading) {
                            Button {
                                print("Custom Button")
                                presentationMode.wrappedValue.dismiss()
                            } label: {
                                HStack {
                                    Image(systemName: "chevron.backward")
                                }
                            }
                        }
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button(action: {
                                self.infoAlert.toggle()
                            }, label: {
                                Image(systemName: "info.circle")
                            }).alertX(isPresented: $infoAlert, content: {
                                AlertX(title: Text("言葉遊びで遊ぶ方法"),
                                message: Text("難易度は3段階に分かれております。初•中級は5回の機会が、高級は6回の機会が与えられます。 それぞれのレベルに合わせて完璧な単語を提出してみてください！難易度は3段階に分かれております。初•中級は5回の機会が、高級は6回の機会が与えられます。"),
                                       theme: .light(withTransparency: false, roundedCorners: true))
                            })
                        }
                    }
                    .foregroundColor(.black)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
        }
        .navigationBarBackButtonHidden(true)
    }
}


struct HardGameView_Previews: PreviewProvider {
    static var previews: some View {
        HardGameView(store: Store(initialState: HardGameState(),
                              reducer: HardGameReducer,
                              environment: HardGameEnv()))
    }
}

struct HardBoardView: View {
    private struct BoxView: View {
        let box: LetterBox
        var body: some View {
            Group {
                switch box {
                case .character(let character, let color):
                    color.backgroundColor
                        .overlay(
                            Text(String(character).uppercased())
                                .font(.custom("MochiyPopOne-Regular", size: 40))
                                .minimumScaleFactor(0.5)
                                .foregroundColor(.black)
                        )
                case .empty:
                    Color.white
                }
            }
            .animation(.linear, value: box)
            .aspectRatio(1, contentMode: .fit)
            .frame(maxWidth: .infinity)
            .cornerRadius(8)
        }
    }
    
    let store: Store<HardGameState, HardGameAction>
    @ObservedObject var viewStore: ViewStore<HardGameState, HardGameAction>
    init(store: Store<HardGameState, HardGameAction>) {
        self.store = store
        self.viewStore = ViewStore(store)
    }
    
    var body: some View {
        let boxes = viewStore.boxes
        VStack {
            ForEach(0..<6) { row in
                HStack {
                    ForEach(0..<5) { col in
                        BoxView(box: boxes[row][col])
                    }
                }
            }
        }
        .padding()
    }
}

