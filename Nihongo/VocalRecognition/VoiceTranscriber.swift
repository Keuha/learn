//
//  VoiceTranscriber.swift
//  Nihongo
//
//  Created by Franck Petriz on 30/08/2023.
//

import Foundation
import Combine
import Speech

class VoiceTranscriber {
    @Published private var transcribtion: Loadable<String> = .notRequested
    
    var transcribtionPublisher: Published<Loadable<String>>.Publisher { $transcribtion }

    var isUsed: Bool {
        switch transcribtion {
        case .loading(_, _):
            return true
        default:
            return false
        }
    }
    
    private let audioEngine = AVAudioEngine()
    private let speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "ja-JP"))
    private var speechRecognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    private var speechRecognitionTask: SFSpeechRecognitionTask?
    
    func startSession() {
        cancelPreviousSession()
        startAudioSession()
        speechRecognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        
        guard let recognitionRequest = speechRecognitionRequest else {
            fatalError(
                "SFSpeechAudioBufferRecognitionRequest object creation failed") }
        
        recognitionRequest.shouldReportPartialResults = true
        
        speechRecognitionTask = speechRecognizer?
            .recognitionTask(with: recognitionRequest) { [weak self] result, error in
                guard let final = result?.bestTranscription.formattedString else {
                    if let err = error {
                        self?.handleError(err)
                    }
                    return
                }
                self?.handleTranscribtion(final.applyingTransform(.toLatin, reverse: false)?.applyingTransform(.latinToHiragana, reverse: false) ?? "")
            }
        startAudio()
    }
    
    private func startAudioSession() {
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(AVAudioSession.Category.record,
                                         mode: .default)
        } catch (let error) {
            dispatchError(error)
        }
        DispatchQueue.main.async {
            self.transcribtion.setIsLoading()
        }
    }
    
    private func startAudio() {
        let recordingFormat = audioEngine.inputNode.outputFormat(forBus: 0)
        audioEngine.inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) {
            (buffer: AVAudioPCMBuffer, when: AVAudioTime) in
            self.speechRecognitionRequest?.append(buffer)
        }
           audioEngine.prepare()
        do {
            try audioEngine.start()
        } catch (let error) {
            dispatchError(error)
        }
    }
    
    private func handleError(_ error: Error) {
        stopSession()
        dispatchError(error)
    }
    
    private func handleTranscribtion(_ final: String) {
        stopSession()
        DispatchQueue.main.async { [weak self] in
            self?.transcribtion.setValue(final)
        }
    }

    func stopSession() {
        audioEngine.stop()
        audioEngine.inputNode.removeTap(onBus: 0)
        speechRecognitionRequest = nil
        speechRecognitionTask = nil
    }

    private func cancelPreviousSession() {
        speechRecognitionTask?.cancel()
        speechRecognitionTask = nil
    }
    
    private func dispatchError(_ error: Error) {
        DispatchQueue.main.async { [weak self] in
            self?.transcribtion.setError(error)
        }
    }
}
