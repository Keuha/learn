//
//  VocabularyDisplay.swift
//  Nihongo
//
//  Created by Franck Petriz on 16/08/2023.
//

import SwiftUI
import AVFoundation

struct VocabularyDisplay: View {
    
    @State private var reveal = false
    @State private var opacity = 0.0
    @State private var content = Content()
    var model = VocabularyDisplayViewModel()

    var body: some View {
        ZStack {
            Color.custom.beige.ignoresSafeArea()
            VStack {
                Spacer()
                readBlock
                translationBlock
                Spacer()
            }
            
        }.onAppear {
            content = model.nextContent()
        }
        .onTapGesture {
            withAnimation {
                if reveal == false {
                    model.readLater(content.hiragana)
                    reveal = true
                    opacity = 1.0
                }
            }
        }
    }
    
    func next() {
        reveal.toggle()
        content = model.nextContent()
    }
    
    @ViewBuilder var translationBlock : some View {
        if reveal {
            translationContent
            .transition(.push(from: .bottom))
        } else {
            translationContent.opacity(0)
        }
    }
    
    @ViewBuilder var translationContent : some View {
        Group {
            Image(systemName: "speaker.wave.2")
                .onTapGesture {
                    model.read(content.hiragana)
                }
                .padding()
            SuitableText(content.translation)
                .onTapGesture {
                    model.read(content.hiragana)
                }
                .padding()
            SuitableText("suivant", fontSize: .subtitle).onTapGesture {
                next()
            }
        }
    }
    
    @ViewBuilder var readBlock : some View {
        Group {
            VStack {
                SuitableText(content.kanji, fontSize: .title)
                    .padding()
                SuitableText(content.hiragana, fontSize: .subtitle)
            }.padding()
        }
    }
}

struct VocabularyDisplayViewModel {
    private let reader: TextReader
    private var generator: ContentGenerator
    
    init(generator: ContentGenerator = VocabularyGenerator(), reader: TextReader = TextToSpeach()) {
        self.generator = generator
        self.reader = reader
    }
    
    func read(_ content: String) {
        reader.read(content)
    }
    
    func readLater(_ content: String) {
        #if targetEnvironment(simulator)
        return
        #else
        //doesn't work on simulator, seems to be buggy
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                read(content)
            }
        #endif
    }
    
    func nextContent() -> Content {
        return generator.nextContent()
    }
}

struct VocabularyDisplay_Previews: PreviewProvider {
    static var previews: some View {
        VocabularyDisplay()
    }
}
