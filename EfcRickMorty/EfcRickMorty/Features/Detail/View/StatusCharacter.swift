//
//  StatusCharacter.swift
//  EfcRickMorty
//
//  Created by efulgencio on 21/4/24.
//

import Foundation

enum StatusCharacter {
    case alive
    case dead
    case unknown
    
    var iconDescription: String? {
        switch self {
        case .alive: return "Alive 🕺"
        case .dead: return "Dead 💀"
        case .unknown: return "?"
        }
    }
}
