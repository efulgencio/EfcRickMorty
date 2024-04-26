//
//  Candle.swift
//  EFCoinCap
//
//  Created by efulgencio on 14/4/24.
//

import Foundation

public struct Locations: Decodable {
    public var data: [Location]
    public init() { self.data = [Location]() }
}

public struct Location: Decodable, Hashable {
    let id: Int
    let name: String
    let type: String
    let dimension: String
    let residents: [String]
    let url: String
    let created: String
}
