//
//  ListRepositoryMock.swift
//  EFCoinCap
//
//  Created by efulgencio on 12/4/24.
//

import Foundation
import Combine

extension ListRepository {
    public static let mock = Self(
        getList: { forFilter in
            let jsonAssetsMock = try! JSONDecoder().decode(ListDTO.self, from: jsonListDTO)
            return Just(jsonAssetsMock)
                .setFailureType(to: NetworkError.self)
                .eraseToAnyPublisher()
        }, getListByPage: { numberPage in
            let jsonAssetsMock = try! JSONDecoder().decode(ListDTO.self, from: jsonListDTO)
            return Just(jsonAssetsMock)
                .setFailureType(to: NetworkError.self)
                .eraseToAnyPublisher()
        }
    )
}

