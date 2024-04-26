//
//  Exchange.swift
//  EFCoinCap
//
//  Created by efulgencio on 14/4/24.
//

import Foundation


public struct Episode: Decodable, Hashable {
    let id: Int
    let name: String
    let air_date: String
    let characters: [String]
    let url: String
    let created: String
}

public struct Episodes: Decodable {
    public var data: [Episode]
    public init() { self.data = [Episode]() }
}
