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
   
    var model = VoiceRecognitionDisplayViewModel()
    @State private var content = Content()
    
    var body: some View {
        ZStack {
            Color.custom.blue.ignoresSafeArea()
            VStack {
                Spacer()
                readBlock
                Spacer()
                micButton
                Spacer()
            }
        }.onAppear {
            content = model.nextContent()
        }.onDisappear {
            model.stopMicrophone()
        }
    }
    
    @ViewBuilder var micButton : some View {
        Button(action: model.triggerMicrophone, label: {
            Text("Test Microphone")
        })
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
    private var voiceTranscriber = VoiceTranscriber()
    private var cancellables: Set<AnyCancellable> = []
    
    init(generator: ContentGenerator = VocabularyGenerator()) {
        self.generator = generator
        self.voiceTranscriber.transcribtionPublisher
            .receive(on: RunLoop.main)
            .sink { (status) in
                switch status {
                case .loaded(let vocal):
                    print("should be in hiragana only \(vocal)")
                case .error(let error):
                    print("an error occured \(error)")
                default:
                    break
            }
        }.store(in: &cancellables)
    }
    
    func nextContent() -> Content {
        return generator.nextContent()
    }
    
    func triggerMicrophone() {
        if voiceTranscriber.isUsed == false {
            voiceTranscriber.startSession()
        }
    }
    
    func stopMicrophone() {
        voiceTranscriber.stopSession()
    }
}

struct VoiceRecognitionDisplay_Previews: PreviewProvider {
    static var previews: some View {
        VoiceRecognitionDisplay()
    }
}
