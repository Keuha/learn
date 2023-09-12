//
//  ContentView.swift
//  Nihongo
//
//  Created by Franck Petriz on 14/08/2023.
//

import SwiftUI

struct WelcomeScreen: View {

    @State private var zoom = false
    @State private var animate = false
    @State private var navigate = false
    @Namespace private var smooth

    var body: some View {
        ZStack {
            Color.Custom.blue.ignoresSafeArea()
            if navigate {
                MenuScreen()
            } else {
                if !zoom {
                    zoomed
                } else {
                    VStack {
                        Button(action: { }, label: {
                            ButtonContent {
                                SuitableText("行けましょう")
                                SuitableText("let's go")
                            }
                        })
                        .buttonStyle(.bordered)
                        .matchedGeometryEffect(id: "morph", in: smooth)
                        .transition(.move(edge: .top))
                    }.animation(.default, value: self.animate)
                }
            }
        }
    }

    var zoomed: some View {
        VStack {
            Spacer()
            SuitableText("日本語を勉強します")
                .padding()
            SuitableText("apprentissage du japonnais")
            Spacer()
            Button(action: transition) {
                ButtonContent {
                    SuitableText("行けましょう")
                    SuitableText("allons-y")
                }
            }
            .buttonStyle(.bordered)
            .matchedGeometryEffect(id: "morph", in: smooth)
        }
        .padding()
    }

    private func transition() {
        withAnimation(.interpolatingSpring(mass: 1,
                                           stiffness: 250,
                                           damping: 15,
                                           initialVelocity: 0)) {
            zoom.toggle()
            animate.toggle()
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.4) {
                animate.toggle()
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.4) {
                    navigate.toggle()
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeScreen()
    }
}
