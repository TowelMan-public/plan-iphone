//
//  SubscriberV1.swift
//  plan-ios
//
//  Created by タオルマン on 2022/02/12.
//

import Foundation
import Combine

class SubscriberV1: PlanBaseApi{
    
    private func createRootUrl(publicProjectId: Int) -> String {
        return PlanApiURL.V1_ROOT_URL + "project/¥(publicProjectId)/subscriber"
    }
    
    func postPublisher(jwtToken: String, publicProjectId: Int, userName: String) -> AnyPublisher<VoidResponse, Error>{
        let url = createRootUrl(publicProjectId: publicProjectId)
        
        let request = PlanRequestParamater()
        request.userName = userName
        
        return restTemplate.postRequestPublisher(url: url, header: JWTHeader(jwtToken), parameters: request)
    }
    
    func getListPublisher(jwtToken: String, publicProjectId: Int) -> AnyPublisher<[SubscriberInPublicProjectResponse], Error>{
        let url = createRootUrl(publicProjectId: publicProjectId)
        
        return restTemplate.getRequestPublisher(url: url, header: JWTHeader(jwtToken))
    }
    
    func putPublisher(jwtToken: String, publicProjectId: Int, userName: String, authority: ProjectAuthority) -> AnyPublisher<VoidResponse, Error>{
        let url = createRootUrl(publicProjectId: publicProjectId)
        
        let request = PlanRequestParamater()
        request.userName = userName
        request.authorityId = authority.rawValue
        
        return restTemplate.putRequestPublisher(url: url, header: JWTHeader(jwtToken), parameters: request)
    }
    
    func deletePublisher(jwtToken: String, publicProjectId: Int, userName: String) -> AnyPublisher<VoidResponse, Error>{
        let url = createRootUrl(publicProjectId: publicProjectId)
        
        let request = PlanRequestParamater()
        request.userName = userName
        
        return restTemplate.deleteRequestPublisher(url: url, header: JWTHeader(jwtToken), parameters: request)
    }
    
    func postAcceptPublisher(jwtToken: String, publicProjectId: Int) -> AnyPublisher<VoidResponse, Error>{
        let url = createRootUrl(publicProjectId: publicProjectId) + "/accept"
        
        return restTemplate.postRequestPublisher(url: url, header: JWTHeader(jwtToken))
    }
    
    func postBlockPublisher(jwtToken: String, publicProjectId: Int) -> AnyPublisher<VoidResponse, Error>{
        let url = createRootUrl(publicProjectId: publicProjectId) + "/block"
        
        return restTemplate.postRequestPublisher(url: url, header: JWTHeader(jwtToken))
    }
    
    func postExitPublisher(jwtToken: String, publicProjectId: Int) -> AnyPublisher<VoidResponse, Error>{
        let url = createRootUrl(publicProjectId: publicProjectId) + "exit"
        
        return restTemplate.postRequestPublisher(url: url, header: JWTHeader(jwtToken))
    }
}
