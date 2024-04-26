//
//  DetailDTO.swift
//  EfcRickMorty
//
//  Created by efulgencio on 18/4/24.
//

import Foundation

/*
public struct DetailDTOx: Decodable {
    let data: Character?
    public init() { self.data = nil }
}
*/
public struct DetailDTO: Codable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let type: String?
    let gender: String
    let origin: LocationDTO
    let location: LocationDTO
    let image: String?
    let episode: [String]?
    let url: String
    let created: String
}

struct LocationDTO: Codable {
    let name: String
    let url: String
}
