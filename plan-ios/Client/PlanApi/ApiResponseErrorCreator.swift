//
//  ApiErrorCreator.swift
//  plan-ios
//
//  Created by タオルマン on 2022/02/09.
//

import Foundation

class ApiResponseErrorCreator: ResponseErrorCreator{
    override func createError(responseData: Data?, response: URLResponse?, error: Error?, decorder: JSONDecoder?) -> Error? {
        
        if let responseData = responseData,
           let decorder = decorder,
           let errorResponse = try? decorder.decode(ErrorResponse.self, from: responseData) {
            
            switch errorResponse.errorCode {
                
            case "ValidateException":
                return ApiError.validate
            case "NotFoundValueException":
                return ApiError.notFoundValue(errorResponse.message)
            case "AlreadyJoinedPublicProjectException":
                return ApiError.alreadyJoinedPublicProject
            case "AlreadySelectedAsTodoResponsibleException":
                return ApiError.alreadySelectedAsTodoResponsible
            case "AlreadyUsedTerminalNameException":
                return ApiError.alreadyUsedTerminalName
            case "AlreadyUsedUserNameException":
                return ApiError.alreadyUsedUserName
            case "BadRequestException":
                return ApiError.badRequest(errorResponse.message)
            case "FailureCreateAuthenticationTokenException":
                return ApiError.failureCreateAuthenticationToken
            case "NotHaveAuthorityToOperateProjectException":
                return ApiError.notHaveAuthorityToOperateProject
            case "NotJoinedPublicProjectException":
                return ApiError.notJoinedPublicProject
            case "NotselectedasTodoResponsibleException":
                return ApiError.notselectedasTodoResponsible
            default:
                return ApiError.unknown(errorResponse.message)
                
            }
        }
        
        return super.createError(responseData: responseData, response: response, error: error, decorder: decorder)
    }
}

fileprivate struct ErrorResponse: Codable{
    var errorCode: String
    var message: String
}

enum ApiError: Error{
    case validate
    case notFoundValue(String)
    case alreadyJoinedPublicProject
    case alreadySelectedAsTodoResponsible
    case alreadyUsedTerminalName
    case alreadyUsedUserName
    case badRequest(String)
    case failureCreateAuthenticationToken
    case notHaveAuthorityToOperateProject
    case notJoinedPublicProject
    case notselectedasTodoResponsible
    case unknown(String)
}
