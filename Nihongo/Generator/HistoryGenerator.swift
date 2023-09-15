//
//  HistoryGenerator.swift
//  Nihongo
//
//  Created by Franck Petriz on 14/09/2023.
//

import Foundation



struct HistoryTracker: HistoryGenerator {
    func track<Tracked: Trackable>(_ content: Tracked, status: Knowledge) {
        let value = content.transform()
        value.setKnowledge(status)
    }
}


protocol HistoryGenerator {
    func track<Tracked: Trackable>(_ content: Tracked, status: Knowledge)
}
