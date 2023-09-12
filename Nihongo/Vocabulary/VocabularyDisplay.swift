//
//  VocabularyDisplay.swift
//  Nihongo
//
//  Created by Franck Petriz on 16/08/2023.
//

import SwiftUI
import AVFoundation

struct VocabularyDisplay: View {
    @Injected(\.settingsProvider) private var settings
    @State private var reveal = false
    @State private var opacity = 0.0
    @State private var content: GeneratedContent?
    var model = VocabularyDisplayViewModel()

    var body: some View {
        ZStack {
            Color.Custom.beige.ignoresSafeArea()
            displayContent
        }.onAppear {
            content = model.nextContent()
        }
        .onTapGesture {
            withAnimation {
                animate()
            }
        }
    }

    func next() {
        reveal.toggle()
        content = model.nextContent()
    }

    func animate() {
        if reveal == false {
            if let content = content {
                model.readLater(content.hiragana)
            }
            reveal = true
            opacity = 1.0
        }
    }

    @ViewBuilder var displayContent: some View {
        VStack {
            Spacer()
            if content != nil {
                readBlock
                translationBlock
            } else {
                congratulation
            }
            Spacer()
        }
    }

    @ViewBuilder var congratulation: some View {
        SuitableText("おめでとう", fontSize: .title)
        SuitableText("お目出度う", fontSize: .subtitle)
        SuitableText("Congratulation").padding()
        SuitableText("you're done for today")
    }

    @ViewBuilder var translationBlock: some View {
        if reveal {
            translationContent
            .transition(.push(from: .bottom))
        } else {
            translationContent.opacity(0)
        }
    }

    @ViewBuilder var translationContent: some View {
        if let content = content {
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
    }

    @ViewBuilder var readBlock: some View {
        if let content = content {
            Group {
                VStack {
                    if content.kanji.isEmpty == false {
                        SuitableText(content.kanji, fontSize: .title)
                            .padding()
                        SuitableText(content.hiragana, fontSize: .subtitle)
                            .opacity((settings.hiraganaDisplay || self.reveal) ? 1 : 0)
                    } else {
                        SuitableText(content.hiragana, fontSize: .title)
                    }
                }.padding()
            }
        }
    }
}

class VocabularyDisplayViewModel {
    private let reader: TextReader
    private var generator: ContentGenerator
    private var generated = 0
    @Injected(\.settingsProvider) private var settings

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
        // doesn't work on simulator, seems to be buggy
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                read(content)
            }
        #endif
    }

    func nextContent() -> GeneratedContent? {
        if generated == settings.numberOfDisplay {
            return nil
        }
        generated += 1
        return generator.nextContent()
    }
}

struct VocabularyDisplay_Previews: PreviewProvider {
    static var previews: some View {
        VocabularyDisplay()
    }
}
