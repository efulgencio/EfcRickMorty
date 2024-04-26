//
//  DetailRepositoryMock.swift
//  EFCoinCap
//
//  Created by efulgencio on 14/4/24.
//

import Foundation
import Combine

extension DetailRepository {
    public static let mock = Self (
        getCharacter: { id in
            let jsonAssets = try! JSONDecoder().decode(DetailDTO.self, from: jsonDetailDTO)
            return Just(jsonAssets)
                .setFailureType(to: NetworkError.self)
                .eraseToAnyPublisher()
        },
        getLocation: { id in
            let jsonHistoriesMock = try! JSONDecoder().decode(DetailDTO.self, from: jsonDetailDTO)
            return Just(jsonHistoriesMock)
                .setFailureType(to: NetworkError.self)
                .eraseToAnyPublisher()
        },
        getEpisode: {
            let jsonMarketsMock = try! JSONDecoder().decode(DetailDTO.self, from: jsonDetailDTO)
            return Just(jsonMarketsMock)
                .setFailureType(to: NetworkError.self)
                .eraseToAnyPublisher()
        }
    )
}
