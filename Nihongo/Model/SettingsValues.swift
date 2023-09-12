//
//  SettingsValues.swift
//  Nihongo
//
//  Created by Franck Petriz on 12/09/2023.
//

import Foundation
import SwiftUI

struct Settings {
    @AppStorage("numberOfDisplay") var numberOfDisplay: Int = 25
    @AppStorage("hiraganaDisplay") var hiraganaDisplay: Bool = true
}

private struct SettingsKey: InjectionKey {
    static var currentValue: Settings = Settings()
}

extension InjectedValues {
    var settingsProvider: Settings {
           get { Self[SettingsKey.self] }
           set { Self[SettingsKey.self] = newValue }
       }
}
