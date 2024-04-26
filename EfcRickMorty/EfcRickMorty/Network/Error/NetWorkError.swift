//
//  NetWork.swift
//  EFCoinCap
//
//  Created by efulgencio on 12/4/24.
//

import Foundation


public struct NetworkError: Error {
    public let errorType: NetworkErrorType
    public let genericResponse: GenericErrorDto?
    public let responseCode: Int
    public let errorTitle: String?
    public let errorDescription: String
    
    public init(errorType: NetworkErrorType, genericResponse: GenericErrorDto? = nil,
                    responseCode: Int, errorTitle: String? = "", errorDescription: String) {
        self.errorType = errorType
        self.genericResponse = genericResponse
        self.responseCode = responseCode
        self.errorTitle = errorTitle
        self.errorDescription = errorDescription
    }
    
    public static func convert(_ error: Error) -> NetworkError {
        guard let error = error as? NetworkError else {
            return NetworkError(errorType: .other,
                                genericResponse: nil,
                                responseCode: 501,
                                errorDescription: error.localizedDescription)
        }
        
        return error
    }
}

public enum NetworkErrorType {
    case afError
    case dspError
    case genericError
    case other
}

public struct GenericErrorDto: Decodable {
    public let code: String?
    public let message: String?
    public let violations: [ViolationsDto]?
    
    private enum CodingKeys: String, CodingKey {
        case code
        case message
        case violations
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        code = try? values.decodeIfPresent(String.self, forKey: .code)
        message = try? values.decodeIfPresent(String.self, forKey: .message)
        violations = try? values.decodeIfPresent([ViolationsDto].self, forKey: .violations)
    }
    
    public init(code: String? = nil, message: String? = nil, violations: [ViolationsDto]?) {
        self.code = code
        self.message = message
        self.violations = violations
    }
}

public struct ViolationsDto: Decodable {
    public let propertyPath: String?
    public let message: String?
    
    private enum CodingKeys: String, CodingKey {
        case propertyPath
        case message
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        propertyPath = try? values.decodeIfPresent(String.self, forKey: .propertyPath)
        message = try? values.decodeIfPresent(String.self, forKey: .message)
    }
    
    public init(propertyPath: String?, message: String?) {
        self.propertyPath = propertyPath
        self.message = message
    }
}
