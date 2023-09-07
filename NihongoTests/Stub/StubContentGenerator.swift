//
//  StubContentGenerator.swift
//  NihongoTests
//
//  Created by Franck Petriz on 20/08/2023.
//

@testable import Nihongo

import Foundation

class StubContentGenerator: ContentGenerator {
    var generatedContent = [Content(kanji: "foo", translation: "test", hiragana: "bar")]
    var nextContentHasBeenCalled = false
    var nextContentHasBeenCalledXTime = 0
    
    func nextContent() -> Nihongo.Content {
        nextContentHasBeenCalled = true
        nextContentHasBeenCalledXTime += 1
        return generatedContent.first!
    }
    
    
}
