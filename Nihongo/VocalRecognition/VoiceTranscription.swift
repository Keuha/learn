//
//  VoiceTranscription.swift
//  Nihongo
//
//  Created by Franck Petriz on 07/09/2023.
//

import Foundation
import Combine

protocol VoiceTranscription {
    var transcribtionPublisher: Published<Loadable<String>>.Publisher { get}
    var isUsed: Bool { get }
    func startSession()
    func stopSession()
}
