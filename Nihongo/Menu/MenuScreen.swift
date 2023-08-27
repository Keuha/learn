//
//  MenuScreen.swift
//  Nihongo
//
//  Created by Franck Petriz on 14/08/2023.
//

import SwiftUI

struct MenuScreen: View {
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.custom.bordeau.ignoresSafeArea()
                VStack {
                    HStack {
                        Spacer()
                        NavigableMenuButton(destination: { VocabularyDisplay() },
                                            buttonContent: {
                                                ButtonContent {
                                                    SuitableText("単語", fontSize: .title)
                                                    SuitableText("たんご", fontSize: .subtitle)
                                                    SuitableText("vocabulaire")
                                                }
                                            })
                        Spacer()
                        NavigableMenuButton(destination: { VoiceRecognitionDisplay() },
                                            buttonContent: {
                                                ButtonContent {
                                                    SuitableText("話す", fontSize: .title)
                                                    SuitableText("はなす", fontSize: .subtitle)
                                                    SuitableText("parler")
                                                }
                                            })
                        Spacer()
                    }.frame(maxWidth: .infinity)
                    
                    VStack {
                        Button(action: action) {
                            ButtonContent {
                                SuitableText("文法", fontSize: .title)
                                SuitableText("ぶんぽう", fontSize: .subtitle)
                                SuitableText("grammaire")
                            }
                        }
                        .buttonStyle(.bordered)
                        
                        Button(action: action) {
                            ButtonContent {
                                SuitableText("メニュー ", fontSize: .title)
                                SuitableText("menu")
                            }
                        }
                        .buttonStyle(.bordered)
                    }
                }
            }
        }
    }
    
    private func action() {
        
    }
}

struct NavigableMenuButton<Destination: View, ButtonContent: View> : View {
    @ViewBuilder var destination: Destination
    @ViewBuilder var buttonContent: ButtonContent
    @State private var tag:Int? = nil
    
    init(@ViewBuilder destination: @escaping () -> Destination,
         @ViewBuilder buttonContent: @escaping () ->ButtonContent) {
        self.destination = destination()
        self.buttonContent = buttonContent()
    }
    
    var body : some View {
        ZStack {
            NavigationLink(destination: destination, tag: 1, selection: $tag) {
                EmptyView()
              }
            Button(action: { tag = 1 }) {
                buttonContent
            }
            .buttonStyle(.bordered)
        }
       
    }
}
