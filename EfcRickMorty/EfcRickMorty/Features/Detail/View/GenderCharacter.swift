//
//  GenderCharacter.swift
//  EfcRickMorty
//
//  Created by efulgencio on 21/4/24.
//

import Foundation

enum GenderCharacter {
    case female
    case male
    case unknown
    
    var iconDescription: String? {
        switch self {
        case .female: return "Mujer 👩‍⚖️"
        case .male: return "Hombre 🤵‍♂️"
        case .unknown: return "?"
        }
    }
}
