//
//  jsonLocation.swift
//  EfcRickMorty
//
//  Created by efulgencio on 20/4/24.
//

import Foundation

let jsonLocation = """
{
   "id": 1,
   "name": "Earth",
   "type": "Planet",
   "dimension": "Dimension C-137",
   "residents": [
     "https://rickandmortyapi.com/api/character/1",
     "https://rickandmortyapi.com/api/character/2",
   ],
   "url": "https://rickandmortyapi.com/api/location/1",
   "created": "2017-11-10T12:42:04.162Z"
 }
""".data(using: .utf8)!
