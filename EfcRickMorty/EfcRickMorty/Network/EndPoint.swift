//
//  EndPoint.swift
//  EfcRickMorty
//
//  Created by efulgencio on 17/4/24.
//

import Foundation

enum EndPointType {
    case all
    case one(Int)
    case multiple([Int])
    case filter(String)
    case page(String)
    
    var route: String {
        switch self {
        case .all:
            return ""
        case .one (let id):
            return "/\(id)"
        case .multiple (let ids):
            return "/\(ids)"
        case .filter (let filter):
            return "/?name=\(filter)"
        case .page (let page):
            return "/?page=\(page)"
        }
    }
}

enum EndPoint: EndPointProtocol  {
    
    case character(EndPointType)
    case location(EndPointType)
    case episode(EndPointType)
    
    var headers: [String : String] {
        var headers: [String: String] = [:]
        headers["Accept"] = "application/json"
        headers["Accept-Language"] = "es"
        return headers
    }
    
    private var baseURL: String {
        return ConfigurationNet.shared.data.baseUrl
    }
    
    var urlString: String {
        switch self {
        case .character(let type), .location(let type), .episode(let type):
            return "\(baseURL)\(endPointType)\(type.route)"
        }
    }
    
    var parameters: [String : Any] {
        var params: [String: Any] = [:]
        switch self {
        case .character(.all):
               // params = ["page": 1] Example for use this property
               params = [:]
            default:
                break
        }
        
        return params
    }
    
    var method: String {
        switch self {
        case .character( _), .location( _), .episode( _):
            return URLRequestMethod.get.rawValue
        }
    }
    
    var endPointType: String {
        switch self {
        case .character:
            return "character"
        case .location:
            return "location"
        case .episode:
            return "episode"
        }
    }

}


