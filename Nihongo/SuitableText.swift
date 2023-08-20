//
//  SuitableText.swift
//  Nihongo
//
//  Created by Franck Petriz on 14/08/2023.
//

import SwiftUI

struct SuitableText: View {
    var content: String
    var size: FontSize
    
    init(_ content: String, fontSize: FontSize = .regular) {
        self.content = content
        self.size = fontSize
    }
    
    var body: some View {
      determineFont()
    }
    
    private func determineFont() -> Text {
        if content.range(of: "\\p{Latin}", options: .regularExpression) == nil {
            return Text(content).font(.custom(customFonts.YS.rawValue, size: size.rawValue))
        }
        return Text(content).font(.custom(customFonts.quicksand.light.rawValue, size: size.rawValue))
    }
}
