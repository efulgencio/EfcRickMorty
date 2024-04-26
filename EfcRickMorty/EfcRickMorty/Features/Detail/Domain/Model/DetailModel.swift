//
//  File.swift
//  EfcRickMorty
//
//  Created by efulgencio on 18/4/24.
//

import Foundation


public final class DetailModel {
    public var data: DetailItem?
    public init() { self.data = nil }
    
    func fromDto(dto: DetailDTO) {
        let item = DetailItem(id: dto.id, 
                              name: dto.name,
                              image: dto.image!,
                              status: defineStatus(statusDto: dto.status),
                              gender: defineGender(genderDto: dto.gender),
                              location: dto.location.name,
                              episode: dto.episode!)
        self.data = item
    }
    
    private func defineStatus(statusDto: String) -> StatusCharacter {
        if statusDto == "Alive" {
            return StatusCharacter.alive
        } else if statusDto == "Dead" {
            return StatusCharacter.dead
        }
        return StatusCharacter.unknown
    }
    
    private func defineGender(genderDto: String) -> GenderCharacter {
        if genderDto == "Female" {
            return GenderCharacter.female
        } else if genderDto == "Male" {
            return GenderCharacter.male
        }
        return GenderCharacter.unknown
    }
}

public struct DetailItem: Identifiable {
    public let id: Int
    let name: String
    let image: String
    let status: StatusCharacter
    let gender: GenderCharacter
    let location: String
    let episode: [String]
}

extension DetailItem {
    
    static func getMock() -> DetailItem {
        return DetailItem(id: 1,
                          name: "item1",
                          image: "https://rickandmortyapi.com/api/character/avatar/1.jpeg",
                          status: StatusCharacter.alive,
                          gender: GenderCharacter.female,
                          location: "location",
                          episode: ["episode"])
    }
}
