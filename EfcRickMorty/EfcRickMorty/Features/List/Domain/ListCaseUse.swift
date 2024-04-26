//
//  ListCaseUse.swift
//  EfcRickMorty
//
//  Created by efulgencio on 16/4/24.
//

import Foundation
import Combine

public struct ListUseCase {
    public var getList: (String) -> AnyPublisher<ListModel, NetworkError>
    public var getListByPage: (String) -> AnyPublisher<ListModel, NetworkError>
    
    init (
        getList: @escaping (String) -> AnyPublisher<ListModel, NetworkError>,
        getListByPage: @escaping (String) -> AnyPublisher<ListModel, NetworkError>
    )
    {
        self.getList = getList
        self.getListByPage = getListByPage
    }
    
}
