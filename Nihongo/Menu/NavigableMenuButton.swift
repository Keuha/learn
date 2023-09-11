//
//  NavigableMenuButton.swift
//  Nihongo
//
//  Created by Franck Petriz on 25/08/2023.
//

import SwiftUI

struct NavigableMenuButton<Destination: View, ButtonContent: View> : View {
    @State private var buttonSelected: Bool = false
    @ViewBuilder var destination: () -> Destination
    @ViewBuilder var buttonContent: () ->ButtonContent
    
    
    init(@ViewBuilder destination: @escaping () -> Destination,
         @ViewBuilder buttonContent: @escaping () ->ButtonContent) {
        self.destination = destination
        self.buttonContent = buttonContent
    }
    
    var body : some View {
        ZStack {
            NavigationStack {
                Button(action: {
                    buttonSelected = true
                }) {
                    buttonContent()
                }.navigationDestination(isPresented: $buttonSelected, destination: { destination() })
            }
        }
       
    }
}
