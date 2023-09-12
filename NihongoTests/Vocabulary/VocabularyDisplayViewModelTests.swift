//
//  VocabularyDisplayViewModelTests.swift
//  NihongoTests
//
//  Created by Franck Petriz on 20/08/2023.
//

import XCTest
@testable import Nihongo

final class VocabularyModelTests: XCTestCase {
    
    
    private func setNumberOfDisplay(_ to: Int = 5) {
        @Injected(\.settingsProvider) var settings
        settings.numberOfDisplay = to
    }
    
    func testNextContent() {
        let reader = StubTextReader()
        let contentGenerator = StubContentGenerator()
        setNumberOfDisplay()
        let model = VocabularyDisplayViewModel(generator: contentGenerator, reader: reader)
        _ = model.nextContent()
        XCTAssertTrue(contentGenerator.nextContentHasBeenCalled)
        XCTAssertEqual(contentGenerator.nextContentHasBeenCalledXTime, 1)
    }
    
    func testNextContentCompare() {
        let reader = StubTextReader()
        let contentGenerator = StubContentGenerator()
        setNumberOfDisplay()
        let model = VocabularyDisplayViewModel(generator: contentGenerator, reader: reader)
        let content = model.nextContent()
        XCTAssertEqual(contentGenerator.generatedContent.first!, content)
    }
    
    func testReader() {
        let reader = StubTextReader()
        let contentGenerator = StubContentGenerator()
        setNumberOfDisplay()
        let model = VocabularyDisplayViewModel(generator: contentGenerator, reader: reader)
        model.read("test")
        XCTAssertTrue(reader.readHasBeenCalled)
        XCTAssertEqual(reader.readHasBeenCalledXTimes, 1)
    }
    
    func testNextContentFollowSettingsWhenZero() {
        let reader = StubTextReader()
        let contentGenerator = StubContentGenerator()
        setNumberOfDisplay(0)
        let model = VocabularyDisplayViewModel(generator: contentGenerator, reader: reader)
        let content = model.nextContent()
        XCTAssertNil(content)
        XCTAssertFalse(contentGenerator.nextContentHasBeenCalled)
    }
    
    func testNextContentFollowSettingsWhenX() {
        let reader = StubTextReader()
        let contentGenerator = StubContentGenerator()
        setNumberOfDisplay(1)
        let model = VocabularyDisplayViewModel(generator: contentGenerator, reader: reader)
        let contentOne = model.nextContent()
        let contentTwo = model.nextContent()
        XCTAssertNotNil(contentOne)
        XCTAssertNil(contentTwo)
        XCTAssertTrue(contentGenerator.nextContentHasBeenCalled)
        XCTAssertEqual(contentGenerator.nextContentHasBeenCalledXTime, 1)
        
    }
}
