//
//  Assets.swift
//  EFCoinCap
//
//  Created by efulgencio on 13/4/24.
//

import Foundation

public struct Character: Decodable {
    let id: Int
    let name: String
    let status: String?
    let species: String?
    let type: String?
    let origin: NameUrl?
    let location: NameUrl?
    let image: String?
    let episode: [String]?
    let url: String?
    let created: String?
}

struct NameUrl: Decodable {
    let name: String
    let url: String
}
