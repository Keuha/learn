//
//  VoiceRecognitionDisplay.swift
//  Nihongo
//
//  Created by Franck Petriz on 21/08/2023.
//

import Foundation
import SwiftUI


struct VoiceRecognitionDisplay: View {
   
    var model = VoiceRecognitionDisplayViewModel()
    @State private var content = Content()
    
    var body: some View {
        ZStack {
            Color.custom.blue.ignoresSafeArea()
            VStack {
                Spacer()
                readBlock
                Spacer()
                Spacer()
            }
        }.onAppear {
            content = model.nextContent()
        }
    }
    
    @ViewBuilder var readBlock : some View {
        Group {
            VStack {
                SuitableText(content.kanji, fontSize: .title)
                    .padding()
                SuitableText(content.hiragana, fontSize: .subtitle)
                SuitableText(content.translation)
            }.padding()
        }
    }
}

struct VoiceRecognitionDisplayViewModel {
    private var generator: ContentGenerator
    
    init(generator: ContentGenerator = VocabularyGenerator()) {
        self.generator = generator
       
    }
    
    func nextContent() -> Content {
        return generator.nextContent()
    }
}

struct VoiceRecognitionDisplay_Previews: PreviewProvider {
    static var previews: some View {
        VoiceRecognitionDisplay()
    }
}
