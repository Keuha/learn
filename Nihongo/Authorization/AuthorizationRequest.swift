//
//  AuthorizationRequest.swift
//  Nihongo
//
//  Created by Franck Petriz on 21/08/2023.
//

import Foundation
import Speech

enum AuthorizationStatus {
    case declined
    case granted
    case undetermined
    case unknown
    
    init(_ status: SFSpeechRecognizerAuthorizationStatus) {
        switch status {
        case .authorized:
            self = .granted
        case .denied:
            self = .declined
        case .notDetermined:
            self = .undetermined
        default:
            self = .unknown
        }
    }
}

protocol AuthorizationRequest {
    var statusPublisher: Published<Loadable<AuthorizationStatus>>.Publisher { get }
    func requestAuthorization()
}
