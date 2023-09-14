//
//  VoiceRecognitionDisplay.swift
//  Nihongo
//
//  Created by Franck Petriz on 21/08/2023.
//

import Foundation
import SwiftUI
import Combine
import SwiftSpeech

struct VoiceRecognitionDisplay: View {

    @ObservedObject var model = VoiceRecognitionDisplayViewModel()
    @State var said: String = ""
    @Injected(\.settingsProvider) var settings
    private var cancelBag = CancelBag()

    var body: some View {
        ZStack {
            Color.Custom.blue.ignoresSafeArea()
            VStack {
                Spacer()
                readBlock
                Spacer()
                SuitableText(said, fontSize: .caption)
                micButton.padding()
                ButtonContent {
                    Button(action: model.nextContent) {
                        Text("skip→")
                    }
                }
                Spacer()
            }
        }
    }

    @ViewBuilder var micButton: some View {
        SwiftSpeech.CustomRecordButton()
            .swiftSpeechRecordOnHold(locale: Locale(identifier: "ja_JP"))
            .onRecognizeLatest(handleResult: { session in
                said = session.bestTranscription.formattedString
                checkValues()
            }, handleError: { _ in })
        .colorInvert()
        .buttonStyle(.borderedProminent)
        .controlSize(.large)
    }

    @ViewBuilder var readBlock: some View {
        Group {
            VStack {
                if settings.voiceKanjiDisplay {
                    SuitableText(model.content.kanji, fontSize: .title)
                        .padding()
                }
                if settings.voiceHiraganaDisplay {
                    SuitableText(model.content.hiragana, fontSize: .subtitle)
                }
                SuitableText(model.content.translation)
            }.padding()
        }
    }

    func checkValues() {
        if model.compareResult(said) {
            said = ""
        }
    }
}

class VoiceRecognitionDisplayViewModel: ObservableObject {
    private var generator: ContentGenerator
    @Published var content: GeneratedContent!

    init(generator: ContentGenerator = VocabularyGenerator()) {
        self.generator = generator
        self.content = generator.nextContent()
    }

    func compareResult(_ said: String) -> Bool {
        if said == content.hiragana || said == content.kanji {
            let impactHeavy = UIImpactFeedbackGenerator(style: .heavy)
            impactHeavy.impactOccurred()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
                self?.nextContent()
            }
            return true
        }
        return false
    }

    func nextContent() {
        content = generator.nextContent()
    }
}
