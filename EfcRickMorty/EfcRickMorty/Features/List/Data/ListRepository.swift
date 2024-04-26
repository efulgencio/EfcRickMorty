//
//  ListRepository.swift
//  EFCoinCap
//
//  Created by efulgencio on 12/4/24.
//

import Foundation
import Combine

public struct ListRepository {
    public var getList: (String) -> AnyPublisher<ListDTO, NetworkError>
    public var getListByPage: (String) -> AnyPublisher<ListDTO, NetworkError>
    
    public init(
        getList: @escaping (String) -> AnyPublisher<ListDTO, NetworkError>,
        getListByPage: @escaping (String) -> AnyPublisher<ListDTO, NetworkError>
    ) {
        self.getList = getList
        self.getListByPage = getListByPage
    }
}


