//
//  MenuScreen.swift
//  Nihongo
//
//  Created by Franck Petriz on 14/08/2023.
//

import SwiftUI

struct MenuScreen: View {
    
    var body: some View {
        ZStack {
            Color("bordeau", bundle: nil).ignoresSafeArea()
            VStack {
                VStack {
                    HStack {
                        Button(action: action) {
                            VStack {
                                Group {
                                    SuitableText("単語")
                                    SuitableText("たんご", fontSize: 20)
                                    SuitableText("vocabulaire")
                                }
                                .foregroundColor(.black)
                                .padding()
                            }
                        }
                        .buttonStyle(.bordered)
                        
                        Button(action: action) {
                            VStack {
                                Group {
                                    SuitableText("単語")
                                    SuitableText("たんご", fontSize: 20)
                                    SuitableText("vocabulaire")
                                }
                                .foregroundColor(.black)
                                .padding()
                            }
                        }
                        .buttonStyle(.bordered)
                    }
                }
                
                VStack {
                    HStack {
                        Button(action: action) {
                            VStack {
                                Group {
                                    SuitableText("単語")
                                    SuitableText("たんご", fontSize: 20)
                                    SuitableText("vocabulaire")
                                }
                                .foregroundColor(.black)
                                .padding()
                            }
                        }
                        .buttonStyle(.bordered)
                        
                        Button(action: action) {
                            VStack {
                                Group {
                                    SuitableText("単語")
                                    SuitableText("たんご", fontSize: 20)
                                    SuitableText("vocabulaire")
                                }
                                .foregroundColor(.black)
                                .padding()
                            }
                        }
                        .buttonStyle(.bordered)
                    }
                }
            }
        }
    }
    
    private func action() {
        
    }
}
