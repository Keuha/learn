//
//  Reader.swift
//  Nihongo
//
//  Created by Franck Petriz on 16/08/2023.
//

import Foundation
import AVFoundation
import SwiftUI

private let synthesizer = AVSpeechSynthesizer()
private let voice = AVSpeechSynthesisVoice(language: "ja-JP")

class TextToSpeach: TextReader {

    init() {
        AVSpeechSynthesisVoice.speechVoices()
    }

    func read(_ content: String) {
        let utterance = AVSpeechUtterance(string: content)
        utterance.pitchMultiplier = 0.8
        utterance.postUtteranceDelay = 0.2
        utterance.volume = 0.8
        utterance.voice = voice
        utterance.rate = 0.4
        synthesizer.speak(utterance)
    }
}

protocol TextReader {
    func read(_ content: String)
}
