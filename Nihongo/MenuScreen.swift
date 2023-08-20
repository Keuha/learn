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
                                SuitableText("単語", fontSize: .title)
                                SuitableText("たんご", fontSize: .subtitle)
                                SuitableText("vocabulaire")
                            }
                        }
                        .buttonStyle(.bordered)
                        
                        Button(action: action) {
                            ButtonContent {
                                    SuitableText("話す", fontSize: .title)
                                    SuitableText("はなす", fontSize: .subtitle)
                                    SuitableText("parler")
                            }
                        }
                        .buttonStyle(.bordered)
                    }
                }
                
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
    
    private func action() {
        
    }
}
