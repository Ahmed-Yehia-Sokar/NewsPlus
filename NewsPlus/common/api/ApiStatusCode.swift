//
//  ApiStatusCode.swift
//  NewsPlus
//
//  Created by admin on 08/05/2023.
//

import Foundation

enum ApiStatusCode: Int, Decodable {
    case unknown = -1
    case unauthorized = 401
    case badRequest = 400
    case forbidden = 403
    case notFound = 404
    case notAcceptable = 406
    
    var description: String {
        switch self {
        case .unknown:
            return "Oops! Something went wrong!"
        case .unauthorized:
            return "Unauthorized"
        case .badRequest:
            return "Bad Request"
        case .forbidden:
            return "Forbidden"
        case .notFound:
            return "Not Found"
        case .notAcceptable:
            return "Not Acceptable"
        }
    }
}
