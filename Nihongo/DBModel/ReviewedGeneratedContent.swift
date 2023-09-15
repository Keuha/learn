//
//  ReviewedGeneratedContent.swift
//  Nihongo
//
//  Created by Franck Petriz on 14/09/2023.
//

import Foundation
import RealmSwift
import SwiftUI

final class ReviewedGeneratedContent: Object, ObjectKeyIdentifiable, Knowledgable {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var kanji: String
    @Persisted var hiragana: String
    @Persisted var translation: String
    @Persisted var streak: Int = 0
    @Persisted var lastViewed: Date = Date(timeIntervalSince1970: 0)
    @Persisted var knowledge: Int = 3

    convenience init(from content: GeneratedContent) {
        self.init()
        kanji = content.kanji
        hiragana = content.hiragana
        translation = content.translation
    }
    
    func setKnowledge(_ level: Knowledge) {
        self.knowledge = level.rawValue
    }

    var generatedContent: GeneratedContent {
        GeneratedContent(kanji: self.kanji,
                         translation: self.translation,
                         hiragana: self.hiragana,
                         knowledge: Knowledge(rawValue: self.knowledge))
    }
}

extension GeneratedContent: Trackable {
    func transform() -> ReviewedGeneratedContent {
        return ReviewedGeneratedContent(from: self)
    }
}
