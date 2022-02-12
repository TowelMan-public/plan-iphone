//
//  PrivateProjectV1.swift
//  plan-ios
//
//  Created by タオルマン on 2022/02/12.
//

import Foundation
import Combine

class PrivateProjectV1: PlanBaseApi{
    private let rootUrl = PlanApiURL.V1_ROOT_URL + "project/private"
    
    func postPublisher(jwtToken: String, name: String) -> AnyPublisher<Int, Error>{
        let url = rootUrl
        
        let request = PlanRequestParamater()
        request.projectName = name
        
        return restTemplate.postRequestPublisher(url: url, header: JWTHeader(jwtToken), parameters: request)
    }
    
    func getListPublisher(jwtToken: String) -> AnyPublisher<[PrivateProjectResponse], Error>{
        let url = rootUrl
        
        return restTemplate.getRequestPublisher(url: url, header: JWTHeader(jwtToken))
    }
    
    func getPublisher(jwtToken: String, id: Int) -> AnyPublisher<PrivateProjectResponse, Error>{
        let url = rootUrl + "/¥(id)"
        
        return restTemplate.getRequestPublisher(url: url, header: JWTHeader(jwtToken))
    }
    
    func putPublisher(jwtToken: String, id: Int, name: String) -> AnyPublisher<VoidResponse, Error>{
        let url = rootUrl + "/¥(id)"
        
        let request = PlanRequestParamater()
        request.projectName = name
        
        return restTemplate.putRequestPublisher(url: url, header: JWTHeader(jwtToken), parameters: request)
    }
    
    func deletePublisher(jwtToken: String, id: Int) -> AnyPublisher<VoidResponse, Error>{
        let url = rootUrl + "/¥(id)"
        
        return restTemplate.deleteRequestPublisher(url: url, header: JWTHeader(jwtToken))
    }
    
    func getIsPrivatePublisher(jwtToken: String, projectId: Int) -> AnyPublisher<Bool, Error>{
        let url = rootUrl + "/¥(projectId)/isPrivate"
        
        return restTemplate.getRequestPublisher(url: url, header: JWTHeader(jwtToken))
    }
}
