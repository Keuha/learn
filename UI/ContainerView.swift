//
//  ContainerView.swift
//  Nihongo
//
//  Created by Franck Petriz on 15/08/2023.
//

import Foundation
import SwiftUI

protocol ContainerView: View {
    associatedtype Content
    init(content: @escaping () -> Content)
}

extension ContainerView {
    init(@ViewBuilder _ content: @escaping () -> Content) {
        self.init(content: content)
    }
}
