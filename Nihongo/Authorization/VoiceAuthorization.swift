//
//  VoiceAuthorization.swift
//  Nihongo
//
//  Created by Franck Petriz on 21/08/2023.
//

import Foundation
import Speech
import SwiftUI
import Combine

class VoiceAuthorization: AuthorizationRequest, ObservableObject {
    @Published private var status: Loadable<AuthorizationStatus> = .notRequested
    
    var statusPublisher: Published<Loadable<AuthorizationStatus>>.Publisher { $status }
    
    @MainActor func requestAuthorization() {
        self.status.setIsLoading()
        SFSpeechRecognizer.requestAuthorization { authStatus in
            DispatchQueue.main.async { [weak self] in
               self?.status.setValue(AuthorizationStatus(authStatus))
            }
        }
    }
    
    init() {
        let value = SFSpeechRecognizer.authorizationStatus()
        DispatchQueue.main.async {
            self.status.setValue(AuthorizationStatus(value))
        }
    }
}
