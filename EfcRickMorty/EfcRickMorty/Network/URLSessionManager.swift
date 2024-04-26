//
//  URLSessionManager.swift
//  EFCoinCap
//
//  Created by efulgencio on 12/4/24.
//

import Foundation
import Combine

final class CombineManager {
    
    static let shared = CombineManager()
    private init() {}
    
    private var cancellables = Set<AnyCancellable>()

    func getData<T: Decodable>(endpoint: EndPointProtocol, type: T.Type) -> AnyPublisher<T, NetworkError> {

        let request = NSMutableURLRequest(url: NSURL(string: endpoint.urlString)! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                      timeoutInterval: 10.0)
        
        request.httpMethod = endpoint.method
        request.allHTTPHeaderFields = endpoint.headers
        
        return  URLSession.shared.dataTaskPublisher(for: request as URLRequest)
            .tryMap { (data, response) -> Data in
                guard let httpResponse = response as? HTTPURLResponse, 200...299 ~= httpResponse.statusCode else {
                    throw NetworkErrorCombine.responseError
                }
                return data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { NetworkError.convert($0) }
            .eraseToAnyPublisher()
    }

}

enum NetworkErrorCombine: Error {
    case invalidURL
    case responseError
    case unknown
}

extension NetworkErrorCombine: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return NSLocalizedString("Invalid URL", comment: "Invalid URL")
        case .responseError:
            return NSLocalizedString("Unexpected status code", comment: "Invalid response")
        case .unknown:
            return NSLocalizedString("Unknown error", comment: "Unknown error")
        }
    }
}
