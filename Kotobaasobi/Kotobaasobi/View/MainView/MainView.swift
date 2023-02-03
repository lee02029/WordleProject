//
//  ContentView.swift
//  Kotobaasobi
//
//  Created by Yoonjae on 2023/01/09.
//

import SwiftUI
import ComposableArchitecture
import AlertX

struct MainView: View {
    @State var infoAlert: Bool = false
    var body: some View {
        NavigationView {
            ZStack {
                Color(hex: "ECE4D2")
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    VStack {
                        Image("WordleMainImage")
                            .imageScale(.large)
                            .foregroundColor(.accentColor)
                        Text("言葉遊び").font(.custom("MochiyPopOne-Regular", size: 34))
                    }
                    .padding(50)
                    // 초급
                    NavigationLink {
                        EasyGameView(store: Store(initialState: EasyGameState(),
                                            reducer: EasyGameReducer,
                                            environment: EasyGameEnv()))
                    } label: {
                        Text("初級")
                            .fontWeight(.medium)
                            .font(.custom("MochiyPopOne-Regular", size: 22))
                            .frame(width: 350, height: 70, alignment: .center)
                            .foregroundColor(.white)
                            .background(Color(hex: "4597F8"))
                    }
                    .cornerRadius(10)
                    .padding()
                    // 중급
                    NavigationLink {
                        NormalGameView(store: Store(initialState: NormalGameState(),
                                            reducer: NormalGameReducer,
                                            environment: NormalGameEnv()))
                    } label: {
                        Text("中級")
                            .fontWeight(.medium)
                            .font(.custom("MochiyPopOne-Regular", size: 22))
                            .frame(width: 350, height: 70, alignment: .center)
                            .foregroundColor(.white)
                            .background(Color(hex: "4597F8"))
                    }
                    .cornerRadius(10)
                    .padding()
                    // 고급
                    NavigationLink {
                        HardGameView(store: Store(initialState: HardGameState(),
                                            reducer: HardGameReducer,
                                            environment: HardGameEnv()))
                    } label: {
                        Text("高級")
                            .fontWeight(.medium)
                            .font(.custom("MochiyPopOne-Regular", size: 22))
                            .frame(width: 350, height: 70, alignment: .center)
                            .foregroundColor(.white)
                            .background(Color(hex: "4597F8"))
                    }
                    .cornerRadius(10)
                    .padding()
                }
                .toolbar() {
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
                .padding()
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
