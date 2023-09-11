//
//  Buttons.swift
//  Nihongo
//
//  Created by Franck Petriz on 15/08/2023.
//

import Foundation
import SwiftUI

struct ButtonContent<Content: View>: ContainerView {
    var content: () -> Content
    
    var body: some View {
        VStack {
            Group {
                content()
            }
            .foregroundColor(.black)
        }.padding()
    }
}
