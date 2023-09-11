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
            VStack {
                NavigableMenuButton(destination: { VocabularyDisplay() },
                                    buttonContent: {
                    ButtonContent {
                        SuitableText("単語", fontSize: .caption)
                        SuitableText("たんご", fontSize: .subtitle).padding(2)
                        SuitableText("vocabulaire")
                    }
                })
                NavigableVoiceMenuButton()
                Button(action: {}) {
                    ButtonContent {
                        SuitableText("文法", fontSize: .caption)
                        SuitableText("ぶんぽう", fontSize: .subtitle).padding(2)
                        SuitableText("grammaire")
                    }
                }
                Button(action: {}) {
                    ButtonContent {
                        SuitableText("メニュー ", fontSize: .caption)
                        SuitableText("menu")
                    }
                }
            }
            .padding(.all)
            .buttonStyle(.bordered)
        }
    }
}
