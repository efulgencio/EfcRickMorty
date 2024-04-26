//
//  DetailCaseUse.swift
//  EFCoinCap
//
//  Created by efulgencio on 14/4/24.
//

import Foundation
import Combine

public struct DetailUseCase {
    public var getCharacter: (Int) -> AnyPublisher<DetailModel, NetworkError>
    public var getLocation: (String) -> AnyPublisher<DetailModel, NetworkError>
    public var getEpisode: () -> AnyPublisher<DetailModel, NetworkError>
    
    init(
            getCharacter: @escaping (Int) -> AnyPublisher<DetailModel, NetworkError>,
            getLocation: @escaping (String) -> AnyPublisher<DetailModel, NetworkError>,
            getEpisode: @escaping () -> AnyPublisher<DetailModel, NetworkError>
        )
    {
        self.getCharacter = getCharacter
        self.getLocation = getLocation
        self.getEpisode = getEpisode
    }
}
