//
//  EndPointProtocol.swift
//  EFCoinCap
//
//  Created by efulgencio on 12/4/24.
//

import Foundation

public protocol EndPointProtocol {
    var headers: [String: String] { get }
    var method: String { get }
    var urlString: String { get }
    var parameters: [String: Any] { get }
}
