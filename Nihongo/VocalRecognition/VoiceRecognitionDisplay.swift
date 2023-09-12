//
//  VoiceRecognitionDisplay.swift
//  Nihongo
//
//  Created by Franck Petriz on 21/08/2023.
//

import Foundation
import SwiftUI
import Combine

struct VoiceRecognitionDisplay: View {

    @ObservedObject var model = VoiceRecognitionDisplayViewModel()

    var body: some View {
        ZStack {
            Color.Custom.blue.ignoresSafeArea()
            VStack {
                Spacer()
                readBlock
                Spacer()
                SuitableText(model.said)
                micButton
                Spacer()
            }
        }.onDisappear {
            model.stopMicrophone()
        }
    }

    @ViewBuilder var micButton: some View {
        Button(action: {}, label: {
            Image(systemName: model.isListening ? "mic.fill" : "mic")
                .font(.title)
                .imageScale(.large)
                .colorInvert()
        })
        .simultaneousGesture(
            DragGesture(minimumDistance: 0)
                .onChanged({ _ in
                    model.startMicrophone()
                })
                .onEnded({ _ in
                    model.stopMicrophone()
                    let impactHeavy = UIImpactFeedbackGenerator(style: .heavy)
                    impactHeavy.impactOccurred()
                })
        )
        .colorInvert()
        .buttonStyle(.borderedProminent)
        .controlSize(.large)
        .foregroundColor(model.isListening ? Color.Custom.brown : Color.Custom.red)
    }

    @ViewBuilder var readBlock: some View {
        Group {
            VStack {
                SuitableText(model.content.kanji, fontSize: .title)
                    .padding()
                SuitableText(model.content.hiragana, fontSize: .subtitle)
                SuitableText(model.content.translation)
            }.padding()
        }
    }
}

class VoiceRecognitionDisplayViewModel: ObservableObject {
    private var generator: ContentGenerator
    private var voiceTranscriber: VoiceTranscription
    private var cancellables: Set<AnyCancellable> = []
    @Published var content: Content!
    @Published var said: String = ""
    @Published var isListening: Bool = false

    init(generator: ContentGenerator = VocabularyGenerator(),
         voiceTranscriber: VoiceTranscription = VoiceTranscriber()) {
        self.generator = generator
        self.content = generator.nextContent()
        self.voiceTranscriber = voiceTranscriber
        self.voiceTranscriber.transcribtionPublisher
            .receive(on: RunLoop.main)
            .sink { [weak self] (status) in
                switch status {
                case .loaded(let vocal):
                    self?.compareResult(vocal)
                default:
                    break
            }
        }.store(in: &cancellables)
    }

    func startMicrophone() {
        if voiceTranscriber.isUsed == false {
            isListening = true
            voiceTranscriber.startSession()
        }
    }

    func stopMicrophone() {
        voiceTranscriber.stopSession()
        isListening = false
    }

    private func compareResult(_ vocal: String) {
        said = vocal
        if vocal == content.hiragana {
            nextContent()
            let impactHeavy = UIImpactFeedbackGenerator(style: .heavy)
            impactHeavy.impactOccurred()
        }
    }

    private func nextContent() {
        content = generator.nextContent()
    }
}

struct VoiceRecognitionDisplay_Previews: PreviewProvider {
    static var previews: some View {
        VoiceRecognitionDisplay()
    }
}
