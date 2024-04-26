//
//  ListCaseLive.swift
//  EfcRickMorty
//
//  Created by efulgencio on 16/4/24.
//

import Foundation
import Combine

extension ListUseCase {
    public static let live = Self (
        getList: { forFilter in
            let listRepository: ListRepository = .live
            return listRepository.getList(forFilter)
                .map { listDto in
                    return ListMapper().mapValue(response: listDto)
                }
                .eraseToAnyPublisher()
        }, getListByPage: { numberPage in
            let listRepository: ListRepository = .live
            return listRepository.getListByPage(numberPage)
                .map { listDto in
                    return ListMapper().mapValue(response: listDto)
                }
                .eraseToAnyPublisher()
        }
    )
}
