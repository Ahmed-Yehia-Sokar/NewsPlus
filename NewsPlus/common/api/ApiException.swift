//
//  ApiException.swift
//  NewsPlus
//
//  Created by admin on 10/05/2023.
//

import Foundation

class ApiException: Error {
    // MARK: - properties.
    let statusCode: ApiStatusCode
    var description: String {
        return statusCode.description
    }
    
    // MARK: - methods.
    init(statusCode: ApiStatusCode = .unknown) {
        self.statusCode = statusCode
    }
}
