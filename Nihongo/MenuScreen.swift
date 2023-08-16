//
//  MenuScreen.swift
//  Nihongo
//
//  Created by Franck Petriz on 14/08/2023.
//

import SwiftUI

struct MenuScreen: View {
    
    var body: some View {
        ZStack {
            Color.custom.bordeau.ignoresSafeArea()
            VStack {
                VStack {
                    HStack {
                        Button(action: action) {
                            ButtonContent {
                                SuitableText("単語")
                                SuitableText("たんご", fontSize: 20)
                                SuitableText("vocabulaire")
                            }
                        }
                        .buttonStyle(.bordered)
                        
                        Button(action: action) {
                            ButtonContent {
                                    SuitableText("話す")
                                    SuitableText("はなす", fontSize: 20)
                                    SuitableText("parler")
                            }
                        }
                        .buttonStyle(.bordered)
                    }
                }
                
                VStack {
                    Button(action: action) {
                        ButtonContent {
                            SuitableText("文法")
                            SuitableText("ぶんぽう", fontSize: 20)
                            SuitableText("grammaire")
                        }
                    }
                    .buttonStyle(.bordered)
                    
                    Button(action: action) {
                        ButtonContent {
                            SuitableText("メニュー ")
                            SuitableText("menu")
                        }
                    }
                    .buttonStyle(.bordered)
                }
            }
        }
    }
    
    private func action() {
        
    }
}
