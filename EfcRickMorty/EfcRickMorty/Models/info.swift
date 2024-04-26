//
//  info.swift
//  EfcRickMorty
//
//  Created by efulgencio on 16/4/24.
//

import Foundation

public struct Info: Decodable, Hashable {
    let count: Int
    let pages: Int
    let next: String?
    let prev: String?
}
