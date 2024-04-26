//
//  ListCaseMock.swift
//  EfcRickMorty
//
//  Created by efulgencio on 16/4/24.
//

import Foundation
import Combine

extension ListUseCase {
    public static let mock = Self (
        getList: { forFilter in
            let listRepository: ListRepository = .mock
            return listRepository.getList(forFilter)
                .map { listDto in
                    return ListMapper().mapValue(response: listDto)
                }
                .eraseToAnyPublisher()
        },getListByPage: { numberPage in
            let listRepository: ListRepository = .mock
            return listRepository.getList(numberPage)
                .map { listDto in
                    return ListMapper().mapValue(response: listDto)
                }
                .eraseToAnyPublisher()
        }
    )
}
