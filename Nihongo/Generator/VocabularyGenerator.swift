//
//  VocabularyGenerator.swift
//  Nihongo
//
//  Created by Franck Petriz on 17/08/2023.
//

import Foundation
import Combine
import SwiftUI

class VocabularyGenerator: ContentGenerator, ObservableObject {
    private var content: [GeneratedContent] = []
    private var previouslyGeneratedContent: [GeneratedContent] = []
    @Published var generatedContent: [GeneratedContent] = []
    init() {
        guard let data = fr_jp else { fatalError("no data") }
        guard let decoded = try? JSONDecoder().decode([GeneratedContent].self, from: data) else {
            fatalError("can't decode")
        }
        content = decoded
        generateContent()
    }

    func generateContent() {
        // get only non already used content
        let unique: [GeneratedContent] = Array(Set([content, previouslyGeneratedContent].flatMap { $0 }))
        var newContent: [GeneratedContent] = []
        for _ in 0...24 {
            if let content = unique.randomElement() {
                newContent.append(content)
            }
        }
        generatedContent = newContent
    }

    func nextContent() -> GeneratedContent {
        let content = generatedContent.removeFirst()
        previouslyGeneratedContent.append(content)
        if generatedContent.count == 0 {
            generateContent()
        }
        return content
    }
}

protocol ContentGenerator {
    var generatedContent: [GeneratedContent] { get }
    func nextContent() -> GeneratedContent
}
