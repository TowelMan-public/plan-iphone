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
            return HttpError.networckError
        }
        
        if let response = response as? HTTPURLResponse {
            switch response.statusCode {
                
            case 400:
                return HttpError.badRequest
            case 401:
                return HttpError.unauthorized
            case 403:
                return HttpError.forbidden
            case 404:
                return HttpError.notFound
            case 400...500:
                return HttpError.clientError
            
            case 500:
                return HttpError.internalServerError
            case 500...:
                return HttpError.serverError
            
                
            default:
                return HttpError.unknown
            }
        }
        
        return HttpError.unknown
    }
}

enum HttpError: Error {
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
