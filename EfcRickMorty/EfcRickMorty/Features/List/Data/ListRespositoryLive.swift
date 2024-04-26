//
//  ListRespositoryLive.swift
//  EFCoinCap
//
//  Created by efulgencio on 12/4/24.
//

import Foundation
import Combine

extension ListRepository {
    public static let live = Self(
        getList: { forFilter in
            if forFilter.isEmpty {
                return CombineManager.shared.getData(endpoint: EndPoint.character(.all), type: ListDTO.self)
            } else {
                return CombineManager.shared.getData(endpoint: EndPoint.character(.filter(forFilter)), type: ListDTO.self)
            }
            
        }, getListByPage: { numberPage in
            return CombineManager.shared.getData(endpoint: EndPoint.character(.page(numberPage)), type: ListDTO.self)
        }
    )
}
