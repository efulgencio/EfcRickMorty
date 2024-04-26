//
//  TextExt.swift
//  EfcRickMorty
//
//  Created by efulgencio on 16/4/24.
//

import Foundation
import SwiftUI

extension Text {
    func customStyle() -> some View {
        self.modifier(CustomTextStyle())
    }
}
