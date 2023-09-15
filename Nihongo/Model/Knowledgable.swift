//
//  Knowledgable.swift
//  Nihongo
//
//  Created by Franck Petriz on 14/09/2023.
//

import Foundation

enum Knowledge: Int, Codable {
    case notKnown = 0
    case difficult = 1
    case new = 2
    case allright = 3
    case easy = 4

    init(rawValue: Int) {
        switch rawValue {
        case 0:
            self = .notKnown
        case 1:
            self = .difficult
        case 3:
            self = .allright
        case 4:
            self = .easy
        default:
            self = .new
        }
    }
}

protocol Knowledgable {

    func setKnowledge(_ level: Knowledge) 
}
