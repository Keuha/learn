//
//  NavigableVoiceMenuButton.swift
//  Nihongo
//
//  Created by Franck Petriz on 27/08/2023.
//

import SwiftUI
import Combine

struct NavigableVoiceMenuButton: View {

    var model = NavigableVoiceMenuButtonViewModel()
    @State var navigate = false
    @State var optionModalDisplay = false

    var body: some View {
        NavigationStack {
            ButtonContent {
                SuitableText("話す", fontSize: .title)
                SuitableText("はなす", fontSize: .subtitle)
                SuitableText("parler")
            }.onTapGesture {
                model.requestVocalAccess()
                model.$vocalAccess
                    .receive(on: RunLoop.main)
                    .sink { status in
                        switch status {
                        case .loaded(let auth):
                            determineNavigation(auth)
                        default:
                            break
                        }
                    }.store(in: &model.cancellables)
            }
        }
        .navigationDestination(isPresented: $navigate,
                               destination: { VoiceRecognitionDisplay() })
        .navigationDestination(isPresented: $optionModalDisplay,
                               destination: { EmptyView() })
    }

    func determineNavigation(_ status: AuthorizationStatus) {
        switch status {
        case .granted:
            navigate = true
        default:
            optionModalDisplay = true
        }
    }
}

class NavigableVoiceMenuButtonViewModel: ObservableObject {

    var authorizationRequest: AuthorizationRequest
    var cancellables: Set<AnyCancellable> = []
    @Published var vocalAccess: Loadable<AuthorizationStatus> = .notRequested

    init(_ authorizationRequest: AuthorizationRequest = VoiceAuthorization()) {
        self.authorizationRequest = authorizationRequest
        authorizationRequest.statusPublisher
            .receive(on: RunLoop.main)
            .sink { (status) in
                self.vocalAccess = status
        }.store(in: &cancellables)
    }

    func requestVocalAccess() {
        switch vocalAccess {
        case .notRequested:
            authorizationRequest.requestAuthorization()
        default:
            break
        }
    }
}
