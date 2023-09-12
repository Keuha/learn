//
//  SettingsView.swift
//  Nihongo
//
//  Created by Franck Petriz on 12/09/2023.
//

import Foundation
import SwiftUI

struct SettingsView: View {
    @Injected(\.settingsProvider) var settings

    var body: some View {
        ZStack {
            Color.Custom.blue.ignoresSafeArea()
            VStack {
                ButtonContent {
                    SuitableText("メニュー ", fontSize: .caption)
                    SuitableText("menu")
                }.buttonStyle(.bordered)
                List {
                    numberOfCard
                    hiraganaDisplay
                }
                .scrollContentBackground(.hidden)
                .scrollDisabled(true)
            }
        }
    }

    var numberOfCard: some View {
        HStack {
            Text("number of cards to review")
                .multilineTextAlignment(.leading)
            Spacer()
            TextField("", value: settings.$numberOfDisplay, formatter: NumberFormatter())
                .keyboardType(.decimalPad)
                .padding()
                .multilineTextAlignment(.trailing)
                .textFieldStyle(.roundedBorder)
                .frame(maxWidth: 100)
                .onSubmit {
                    hideKeyboard()
                }
        }
    }

    var hiraganaDisplay: some View {
        HStack {
            Toggle("number of cards to review", isOn: settings.$hiraganaDisplay)
                .padding(.bottom)
                .padding(.top)
        }
    }
}
