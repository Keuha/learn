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
            model.startMicrophone()
        }.onDisappear {
            model.stopMicrophone()
        }
    }
    
    @ViewBuilder var micButton : some View {
       
        Button(action: {
           
        }) {
            Image(systemName: model.isListening ? "mic.fill" : "mic")
                .font(.title)
                .imageScale(.large)
                .colorInvert()
        }
        .buttonStyle(.bordered)
        .controlSize(.large)
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

class VoiceRecognitionDisplayViewModel: ObservableObject {
    private var generator: ContentGenerator
    private var voiceTranscriber = VoiceTranscriber()
    private var cancellables: Set<AnyCancellable> = []
    private var content: Content!
    @Published var isListening: Bool = false
    
    init(generator: ContentGenerator = VocabularyGenerator()) {
        self.generator = generator
        self.voiceTranscriber.transcribtionPublisher
            .receive(on: RunLoop.main)
            .sink { [weak self] (status) in
                switch status {
                case .loaded(let vocal):
                    print("should be in hiragana only \(vocal)")
                    self?.compareResult(vocal)
                case .error(let error):
                    print("an error occured \(error)")
                default:
                    break
            }
        }.store(in: &cancellables)
    }
    
    func nextContent() -> Content {
        content = generator.nextContent()
        return content
    }
    
    func startMicrophone() {
        if voiceTranscriber.isUsed == false {
            voiceTranscriber.startSession()
        }
    }
    
    func stopMicrophone() {
        voiceTranscriber.stopSession()
    }
    
    private func compareResult(_ vocal: String) {
        if vocal == content.hiragana {
            print("navigate to next content")
        } else {
            print("react to the error")
        }
    }
}

struct VoiceRecognitionDisplay_Previews: PreviewProvider {
    static var previews: some View {
        VoiceRecognitionDisplay()
    }
}
