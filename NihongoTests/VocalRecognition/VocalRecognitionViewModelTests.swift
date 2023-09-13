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
        let contentGenerator = StubContentGenerator()
        _ = VoiceRecognitionDisplayViewModel(generator: contentGenerator)
        XCTAssertTrue(contentGenerator.nextContentHasBeenCalled)
        XCTAssertEqual(contentGenerator.nextContentHasBeenCalledXTime, 1)
    }
    
    func testTranscriptionMatch() {
        let contentGenerator = StubContentGenerator()
        let cancelBag = CancelBag()
        let model = VoiceRecognitionDisplayViewModel(generator: contentGenerator)
        let exp = expectation(description: "wait for action to be propagate")
        model.compareResult(contentGenerator.generatedContent.first!.kanji)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
            // animation takes upe to 0.5 to perform change
            exp.fulfill()
        }
        waitForExpectations(timeout: 1)
        XCTAssertEqual(contentGenerator.nextContentHasBeenCalledXTime, 2) // called at init + called because match
    }
    
    func testTranscriptionDoesNotMatch() {
        let contentGenerator = StubContentGenerator()
        let model = VoiceRecognitionDisplayViewModel(generator: contentGenerator)
        model.compareResult("nope")
        XCTAssertEqual(contentGenerator.nextContentHasBeenCalledXTime, 1)// called at init only
    }
}
