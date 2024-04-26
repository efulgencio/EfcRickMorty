//
//  CharacterModel.swift
//  EfcRickMorty
//
//  Created by efulgencio on 18/4/24.
//

import Foundation

public final class ListModel: RandomAccessCollection, Decodable {
    public var data: [ListItem]
    public var numberPages: Int = 0
    public init() { self.data = [ListItem]() }

       public var startIndex: Int { data.startIndex }
       public var endIndex: Int { data.endIndex }
       
       public func index(after i: Int) -> Int {
           data.index(after: i)
       }
    
       public subscript(position: Int) -> ListItem {
           data[position]
       }
    
    func fromDto(dto: ListDTO) {
        self.numberPages = dto.info.pages
        for character in dto.results {
            let item = ListItem(id: character.id, name: character.name, image: character.image!)
            self.data.append(item)
        }
    }
}

public struct ListItem: Identifiable, Decodable {
    public let id: Int
    let name: String
    let image: String
}

extension ListItem {
    
    static func mock() -> ListItem {
        return ListItem(id: 2,
                        name: "Morty Smith",
                        image: "https://rickandmortyapi.com/api/character/avatar/2.jpeg")
    }
}
