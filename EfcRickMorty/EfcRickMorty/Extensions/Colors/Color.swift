//
//  Color.swift
//  EFCoinCap
//
//  Created by efulgencio on 13/4/24.
//

import Foundation
import SwiftUI

extension Color {
    static let themeOption = ColorThemeOption()
    static let themeCardDetail = ColorThemeCardDetail()
    static let themeItem = ColorThemeItem()
}

struct ColorThemeOption {
    let optionOne = Color("OptionOne")
    let optionTwo = Color("OptionTwo")
    let optionThree = Color("OptionThree")
    
    let unSelectedOption = Color("UnSelectedOption")
}

struct ColorThemeCardDetail {
    let header = Color("HeaderCard")
    let body = Color("BodyCard")
}

struct ColorThemeItem {
    let header = Color("HeaderItem")
    let body = Color("BodyItem")
}
