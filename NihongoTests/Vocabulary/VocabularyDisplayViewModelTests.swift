//
//  VocabularyDisplayViewModelTests.swift
//  NihongoTests
//
//  Created by Franck Petriz on 20/08/2023.
//

import XCTest
@testable import Nihongo

final class VocabularyModelTests: XCTestCase {
    
    func testNextContent() {
        let reader = StubTextReader()
        let contentGenerator = StubContentGenerator()
        let model = VocabularyDisplayViewModel(generator: contentGenerator, reader: reader)
        _ = model.nextContent()
        XCTAssertTrue(contentGenerator.nextContentHasBeenCalled)
        XCTAssertEqual(contentGenerator.nextContentHasBeenCalledXTime, 1)
    }
    
    func testNextContentCompare() {
        let reader = StubTextReader()
        let contentGenerator = StubContentGenerator()
        let model = VocabularyDisplayViewModel(generator: contentGenerator, reader: reader)
        let content = model.nextContent()
        XCTAssertEqual(contentGenerator.generatedContent.first!, content)
    }
    
    func testReader() {
        let reader = StubTextReader()
        let contentGenerator = StubContentGenerator()
        let model = VocabularyDisplayViewModel(generator: contentGenerator, reader: reader)
        model.read("test")
        XCTAssertTrue(reader.readHasBeenCalled)
        XCTAssertEqual(reader.readHasBeenCalledXTimes, 1)
    }
}
