//
//  VocabularyGenerator.swift
//  Nihongo
//
//  Created by Franck Petriz on 17/08/2023.
//

import Foundation
import Combine
import SwiftUI

struct Content: Codable, Equatable, Hashable {
    var kanji: String = ""
    var translation: String = ""
    var hiragana: String = ""
}

class VocabularyGenerator: ContentGenerator, ObservableObject {
    private var content: [Content] = []
    private var previouslyGeneratedContent: [Content] = []
    @Published var generatedContent: [Content] = []
    init() {
        guard let data = fr_jp else { fatalError("no data") }
        guard let content = try? JSONDecoder().decode([Content].self, from: data) else { fatalError("can't decode") }
        generateContent()
    }

    func generateContent() {
        // get only non already used content
        let unique: [Content] = Array(Set([content, previouslyGeneratedContent].flatMap { $0 }))
        var newContent: [Content] = []
        for _ in 0...24 {
            if let content = unique.randomElement() {
                newContent.append(content)
            }
        }
        generatedContent = newContent
    }

    func nextContent() -> Content {
        let content = generatedContent.removeFirst()
        previouslyGeneratedContent.append(content)
        if generatedContent.count == 0 {
            generateContent()
        }
        return content
    }
}

protocol ContentGenerator {
    var generatedContent: [Content] { get }
    func nextContent() -> Content
}
