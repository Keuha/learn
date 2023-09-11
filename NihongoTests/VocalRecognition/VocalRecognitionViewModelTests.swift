//
//  VocalRecognitionViewModelTests.swift
//  NihongoTests
//
//  Created by Franck Petriz on 07/09/2023.
//

import XCTest
@testable import Nihongo
import Combine

final class VocalRecognitionViewModelTests: XCTestCase {
    
    func testNextContent() {
        // next content should be called during init time of the view model
        let voiceReco = StubVoiceTranscriber()
        let contentGenerator = StubContentGenerator()
        _ = VoiceRecognitionDisplayViewModel(generator: contentGenerator, voiceTranscriber: voiceReco)
        XCTAssertTrue(contentGenerator.nextContentHasBeenCalled)
        XCTAssertEqual(contentGenerator.nextContentHasBeenCalledXTime, 1)
    }
    
    func testStartSession() {
        var cancellables: Set<AnyCancellable> = []
        let voiceReco = StubVoiceTranscriber()
        let contentGenerator = StubContentGenerator()
        let model = VoiceRecognitionDisplayViewModel(generator: contentGenerator, voiceTranscriber: voiceReco)
        let exp = expectation(description: "wait for action to be propagate")
        voiceReco.transcribtionPublisher
            .receive(on: RunLoop.main)
            .sink { status in
                switch status {
                case .loaded(_), .loading(_, _):
                    XCTAssertTrue(voiceReco.startSessionHasBeenCalled)
                    XCTAssertFalse(voiceReco.stopSessionHasBeenCalled)
                    exp.fulfill()
                default:
                    break
                }
            }.store(in: &cancellables)
        model.startMicrophone()
        waitForExpectations(timeout: 1)
        XCTAssertFalse(voiceReco.stopSessionHasBeenCalled)
    }
    
    func testStopSession() {
        var cancellables: Set<AnyCancellable> = []
        let voiceReco = StubVoiceTranscriber()
        let contentGenerator = StubContentGenerator()
        let model = VoiceRecognitionDisplayViewModel(generator: contentGenerator, voiceTranscriber: voiceReco)
        let exp = expectation(description: "wait for action to be propagate")
        voiceReco.transcribtionPublisher
            .receive(on: RunLoop.main)
            .sink { status in
                switch status {
                case .loaded(_), .loading(_, _):
                    exp.fulfill()
                default:
                    break
                }
            }.store(in: &cancellables)
        model.startMicrophone()
        waitForExpectations(timeout: 1)
        model.stopMicrophone()
        XCTAssertFalse(model.isListening)
        XCTAssertTrue(voiceReco.stopSessionHasBeenCalled)
    }
    
    func testTranscriptionMatch() {
        var cancellables: Set<AnyCancellable> = []
        let voiceReco = StubVoiceTranscriber()
        let contentGenerator = StubContentGenerator()
        voiceReco.transcribtionToReturn = contentGenerator.generatedContent.first!.hiragana
        let model = VoiceRecognitionDisplayViewModel(generator: contentGenerator, voiceTranscriber: voiceReco)
        let exp = expectation(description: "wait for action to be propagate")
        var resultToCompare = ""
        voiceReco.transcribtionPublisher
            .receive(on: RunLoop.main)
            .sink { status in
                switch status {
                case .loaded(let result):
                    resultToCompare = result
                    exp.fulfill()
                default:
                    break
                }
            }.store(in: &cancellables)
        model.startMicrophone()
        waitForExpectations(timeout: 1)
        XCTAssertEqual(contentGenerator.nextContentHasBeenCalledXTime, 2) // sting matches, new content should be generated
        XCTAssertEqual(model.said, resultToCompare)
    }
    
    func testTranscriptionDoesNotMatch() {
        var cancellables: Set<AnyCancellable> = []
        let voiceReco = StubVoiceTranscriber()
        let contentGenerator = StubContentGenerator()
        voiceReco.transcribtionToReturn = "zog"
        let model = VoiceRecognitionDisplayViewModel(generator: contentGenerator, voiceTranscriber: voiceReco)
        let exp = expectation(description: "wait for action to be propagate")
        voiceReco.transcribtionPublisher
            .receive(on: RunLoop.main)
            .sink { status in
                switch status {
                case .loaded(_):
                    exp.fulfill()
                default:
                    break
                }
            }.store(in: &cancellables)
        model.startMicrophone()
        waitForExpectations(timeout: 1)
        XCTAssertEqual(contentGenerator.nextContentHasBeenCalledXTime, 1) // sting does not matche, new content should not be generated
    }
}
