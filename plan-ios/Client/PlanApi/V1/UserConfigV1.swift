//
//  UserConfigV1.swift
//  plan-ios
//
//  Created by タオルマン on 2022/02/12.
//

import Foundation
import Combine

class UserConfigV1: PlanBaseApi{
    private let rootUrl = PlanApiURL.V1_ROOT_URL + "user/config"
    
    func getPublisher(jwtToken: String) -> AnyPublisher<UserConfigResponse, Error>{
        return restTemplate.getRequestPublisher(url: rootUrl, header: JWTHeader(jwtToken))
    }
    
    func putPublisher(jwtToken: String, beforeDeadlineForTodoNotice: Int? = nil, beforeDeadlineForProjectNotice: Int? = nil, isPushInsertedTodoNotice: Bool? = nil, isPushStartedTodoNotice: Bool? = nil) -> AnyPublisher<VoidResponse, Error>{
        let request = PlanRequestParamater()
        request.beforeDeadlineForTodoNotice = beforeDeadlineForTodoNotice
        request.beforeDeadlineForProjectNotice = beforeDeadlineForProjectNotice
        request.isPushStartedTodoNotice = isPushStartedTodoNotice
        request.pushInsertedTodoNotice = isPushInsertedTodoNotice
        
        return restTemplate.putRequestPublisher(url: rootUrl, header: JWTHeader(jwtToken), parameters: request)
    }
}
