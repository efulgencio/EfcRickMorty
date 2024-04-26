//
//  DetailRepository.swift
//  EFCoinCap
//
//  Created by efulgencio on 14/4/24.
//

import Foundation
import Combine

public struct DetailRepository {
    public var getCharacter: (Int) -> AnyPublisher<DetailDTO, NetworkError>
    public var getLocation: (String) -> AnyPublisher<DetailDTO, NetworkError>
    public var getEpisode: () -> AnyPublisher<DetailDTO, NetworkError>

    public init(
            getCharacter: @escaping (Int) -> AnyPublisher<DetailDTO, NetworkError>,
            getLocation: @escaping (String) -> AnyPublisher<DetailDTO, NetworkError>,
            getEpisode: @escaping () -> AnyPublisher<DetailDTO, NetworkError>
    ) {
        self.getCharacter = getCharacter
        self.getLocation = getLocation
        self.getEpisode = getEpisode
    }
}
