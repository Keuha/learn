//
//  StubVoiceTranscriber.swift
//  NihongoTests
//
//  Created by Franck Petriz on 07/09/2023.
//

@testable import Nihongo
import Foundation
import Combine

class StubVoiceTranscriber: VoiceTranscription {
    
    var shouldBeUsed : Bool = true
    var transcribtionToReturn = ""
    var error: Error? = nil
    var isUsed: Bool = false
    var transcribtionPublisher: Published<Nihongo.Loadable<String>>.Publisher { $transcribtion }
    
    var startSessionHasBeenCalled = false
    var stopSessionHasBeenCalled = false
    
    @Published private var transcribtion: Loadable<String> = .notRequested
    
    func startSession() {
        isUsed = true
        startSessionHasBeenCalled = true
        DispatchQueue.main.async { [weak self] in
            if self?.error == nil {
                self?.transcribtion.setValue(self!.transcribtionToReturn)
            } else {
                self?.transcribtion.setError(self!.error!)
            }
        }
    }
    
    func stopSession() {
        isUsed = false
        stopSessionHasBeenCalled = true
    }
    
    
}

