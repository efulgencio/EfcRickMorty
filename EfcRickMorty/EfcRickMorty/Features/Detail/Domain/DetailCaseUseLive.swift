//
//  DetailCaseUseLive.swift
//  EFCoinCap
//
//  Created by efulgencio on 14/4/24.
//

import Foundation
import Combine

extension DetailUseCase {
    public static let live = Self(
        getCharacter: { id in
            let detailRepository: DetailRepository = .live
            return detailRepository.getCharacter(id)
                    .map { listDto in
                        return DetailMapper().mapValue(response: listDto)
                    }
                    .eraseToAnyPublisher()
        },
        getLocation: { id in
            let detailRepository: DetailRepository = .live
            return detailRepository.getLocation(id)
                    .map { listDto in
                        return DetailMapper().mapValue(response: listDto)
                    }
                    .eraseToAnyPublisher()
        }, getEpisode: {
            let detailRepository: DetailRepository = .live
            return detailRepository.getEpisode()
                    .map { listDto in
                        return DetailMapper().mapValue(response: listDto)
                    }
                    .eraseToAnyPublisher()
        }
    )
}
