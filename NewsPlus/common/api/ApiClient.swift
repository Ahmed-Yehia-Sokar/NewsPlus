//
//  ApiClient.swift
//  NewsPlus
//
//  Created by admin on 10/05/2023.
//

import Foundation
import Alamofire
import Combine

class ApiClient {
    // MARK: - public methods.
    func performRequest<T: Decodable>(url: String,
                                      headers: HTTPHeaders? = nil,
                                      method: HTTPMethod,
                                      parameters: Parameters? = nil,
                                      decoder: JSONDecoder = JSONDecoder()) -> Future<T, Error> {
        Future { promise in
            AF.request(url,
                       method: method,
                       parameters: parameters,
                       headers: headers)
            .validate()
            .response { (afDataResponse: AFDataResponse) in
                switch afDataResponse.result {
                case .success(let value):
                    if let value = value {
                        if let urlResponse = afDataResponse.response,
                           (200...299).contains(urlResponse.statusCode),
                           let decodedData = try? decoder.decode(T.self, from: value) {
                            promise(.success(decodedData))
                        } else {
                            // Handle the case if the incoming response contains an error.
                            if let apiException = try? decoder.decode(ApiException.self, from: value) {
                                promise(.failure(apiException))
                            }
                        }
                    } else {
                        let apiException = self.getApiException()
                        promise(.failure(apiException))
                    }
                case .failure(_):
                    let apiException = self.getApiException(afDataResponse.error)
                    promise(.failure(apiException))
                }
            }
        }
    }
    
    // MARK: - private methods.
    private func getApiException(_ error: AFError? = nil) -> ApiException {
        var statusCode = ApiStatusCode.unknown
        
        if let responseCode = error?.responseCode {
            statusCode = ApiStatusCode(rawValue: responseCode) ?? .unknown
        }
        
        return ApiException(statusCode: statusCode)
    }
}
