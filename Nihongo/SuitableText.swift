//
//  SuitableText.swift
//  Nihongo
//
//  Created by Franck Petriz on 14/08/2023.
//

import SwiftUI

struct SuitableText: View {
    var content: String
    var size: CGFloat
    
    init(_ content: String, fontSize: CGFloat = 16) {
        self.content = content
        self.size = 16
    }
    
    var body: some View {
        return determineFont()
    }
    
    private func determineFont() -> Text {
        if content.range(of: "\\p{Latin}", options: .regularExpression) == nil {
            return Text(content).font(.custom(customFonts.YS.rawValue, size: 33))
        }
        return Text(content).font(.custom(customFonts.quicksand.light.rawValue, size: size))
    }
}
