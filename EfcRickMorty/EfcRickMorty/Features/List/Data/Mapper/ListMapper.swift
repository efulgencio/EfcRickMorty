//
//  ListMapper.swift
//  EFCoinCap
//
//  Created by efulgencio on 14/4/24.
//

import Foundation


public class ListMapper: Mapper<ListDTO, ListModel> {
    public override func mapValue(response: ListDTO) -> ListModel {
        let listFormatted = ListModel()
        listFormatted.fromDto(dto: response)
        return listFormatted
    }
}
