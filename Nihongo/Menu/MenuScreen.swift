//
//  MenuScreen.swift
//  Nihongo
//
//  Created by Franck Petriz on 14/08/2023.
//

import SwiftUI
import Combine

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
                    NavigableVoiceMenuButton()
                }
                    Spacer()
                }.frame(maxWidth: .infinity)
                
                VStack {
                    Button(action: {}) {
                        ButtonContent {
                            SuitableText("文法", fontSize: .title)
                            SuitableText("ぶんぽう", fontSize: .subtitle)
                            SuitableText("grammaire")
                        }
                    }
                    .buttonStyle(.bordered)
                    
                    Button(action: {}) {
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

