//
//  ContentView.swift
//  Nihongo
//
//  Created by Franck Petriz on 14/08/2023.
//

import SwiftUI

struct WelcomeScreen: View {
    
    @State private var zoomed = false
    @State private var navigate = false
    @Namespace private var smooth
    
    var body: some View {
        if navigate {
            MenuScreen()
                .transition(.slide)
        } else {
            ZStack {
                Color("bordeau", bundle: nil).ignoresSafeArea()
                if !zoomed {
                    VStack {
                        Spacer()
                        SuitableText("日本語を勉強します")
                            .padding()
                        SuitableText("apprentissage du japonnais")
                        Spacer()
                        Button(action: transition) {
                            VStack {
                                Group {
                                    SuitableText("行けましょう")
                                    SuitableText("allons-y")
                                }
                                .foregroundColor(.black)
                                .padding()
                            }
                        }
                        .buttonStyle(.bordered)
                        .matchedGeometryEffect(id: "morph", in: smooth)
                        
                    }
                    .padding()
                } else {
                    Button(action: { }) {
                        VStack {
                            Group {
                                SuitableText("行けましょう")
                                SuitableText("let's go")
                            }
                            .foregroundColor(.black)
                            .padding()
                        }
                    }
                    .disabled(true)
                    .buttonStyle(.bordered)
                    .matchedGeometryEffect(id: "morph", in: smooth)
                    .padding()
                }
                
            }
        }
    }
    
    private func transition() {
        withAnimation(.interpolatingSpring(mass: 1,
                                           stiffness: 250,
                                           damping: 15,
                                           initialVelocity: 0)){
                    zoomed.toggle()
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.4) {
            self.navigate = true
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeScreen()
    }
}
