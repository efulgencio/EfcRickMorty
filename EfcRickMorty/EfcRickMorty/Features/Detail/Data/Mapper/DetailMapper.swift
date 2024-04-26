//
//  DetailMapper.swift
//  EfcRickMorty
//
//  Created by efulgencio on 18/4/24.
//

import Foundation


public class DetailMapper: Mapper<DetailDTO, DetailModel> {
    public override func mapValue(response: DetailDTO) -> DetailModel {
        let detailFormatted = DetailModel()
        detailFormatted.fromDto(dto: response)
        return detailFormatted
    }
}

