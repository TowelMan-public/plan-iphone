//
//  ResponseErrorHandlerProtocol.swift
//  plan-ios
//
//  Created by タオルマン on 2022/02/08.
//

import Foundation

class ResponseErrorCreator{
    func createError(responseData: Data?, response: URLResponse?, error: Error?, decorder: JSONDecoder?) -> Error?{
        
        if error == nil {
            return nil
        }
        
        if responseData == nil{
            return ApiError.networckError
        }
        
        if let response = response as? HTTPURLResponse {
            switch response.statusCode {
                
            case 400:
                return ApiError.badRequest
            case 401:
                return ApiError.unauthorized
            case 403:
                return ApiError.forbidden
            case 404:
                return ApiError.notFound
            case 400...500:
                return ApiError.clientError
            
            case 500:
                return ApiError.internalServerError
            case 500...:
                return ApiError.serverError
            
                
            default:
                return ApiError.unknown
            }
        }
        
        return ApiError.unknown
    }
}

enum ApiError: Error {
    case networckError
    case notFound
    case unknown
    case forbidden
    case unauthorized
    case badRequest
    case clientError
    case internalServerError
    case serverError
}
