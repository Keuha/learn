//
//  View.swift
//  Nihongo
//
//  Created by Franck Petriz on 12/09/2023.
//

import Foundation
import SwiftUI
#if canImport(UIKit)
public extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif
