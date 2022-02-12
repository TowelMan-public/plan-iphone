//
//  UserV1.swift
//  plan-ios
//
//  Created by タオルマン on 2022/02/12.
//

import Foundation
import Combine

class UserV1: PlanBaseApi{
    private let rootUrl = PlanApiURL.V1_ROOT_URL + "user"
    
    func postTokenPublisher(userName: String, password: String) -> AnyPublisher<TokenResponse, Error>{
        let url = rootUrl + "/token"
        
        let request = PlanRequestParamater()
        request.userName = userName
        request.password = password
        
        return restTemplate.postRequestPublisher(url: url, parameters: request)
    }
    
    func postNewTokenPublisher(refreshToken: String) -> AnyPublisher<TokenResponse, Error>{
        let url = rootUrl + "/token"
        
        let request = PlanRequestParamater()
        request.refreshJwtToken = refreshToken
        
        return restTemplate.postRequestPublisher(url: url, parameters: request)
    }
    
    func postPublisher(userName: String, userNickName: String, password: String) -> AnyPublisher<VoidResponse, Error>{
        let request = PlanRequestParamater()
        request.userName = userName
        request.userNickName = userNickName
        request.password = password
        
        return restTemplate.postRequestPublisher(url: rootUrl, parameters: request)
    }
    
    func putPublisher(jwtToken: String, userName: String? = nil, userNickName: String? = nil, password: String? = nil) -> AnyPublisher<VoidResponse, Error>{
        let request = PlanRequestParamater()
        request.userName = userName
        request.userNickName = userNickName
        request.password = password
        
        return restTemplate.putRequestPublisher(url: rootUrl, header: JWTHeader(jwtToken), parameters: request)
    }
    
    func getPublisher(jwtToken: String, userName: String? = nil) -> AnyPublisher<UserResponse, Error>{
        let request = PlanRequestParamater()
        request.userName = userName
        
        return restTemplate.getRequestPublisher(url: rootUrl, header: JWTHeader(jwtToken), parameters: request)
    }
    
    func delete(jwtToken: String) -> AnyPublisher<VoidResponse, Error>{
        return restTemplate.deleteRequestPublisher(url: rootUrl, header: JWTHeader(jwtToken))
    }
}
