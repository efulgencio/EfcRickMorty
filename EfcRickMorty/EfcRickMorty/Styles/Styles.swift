//
//  Styles.swift
//  EfcRickMorty
//
//  Created by efulgencio on 16/4/24.
//

import Foundation
import SwiftUI

struct CustomTextStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.headline)
            .fontWeight(.heavy)
    }
}

struct CustomModifierCardDetailItem: ViewModifier {
    
    let colorBack: Color?
    let heightContent: CGFloat?
    
    init(colorBack: Color = Color.themeItem.header, heightContent: CGFloat = CGFloat(80) ) {
        self.colorBack = colorBack
        self.heightContent = heightContent
    }
    
    func body(content: Content) -> some View {
        content
            .frame(height: heightContent)
            .frame(maxWidth: .infinity)
            .background(colorBack)
            .foregroundColor(.white)
            .clipShape(RoundedCorner(radius: 30, corners: [.bottomLeft, .topRight]))
            .padding(.leading, 0)
            .padding(.trailing, 0)
        
    }
}
