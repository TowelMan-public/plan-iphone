//
//  ContentV1.swift
//  plan-ios
//
//  Created by タオルマン on 2022/02/11.
//

import Foundation
import Combine

class ContentV1: PlanBaseApi{
    private let rootUrl = PlanApiURL.V1_ROOT_URL + "content"
    
    func postPublisher(jwtToken: String, todoId: Int, title: String, explanation: String) -> AnyPublisher<Int, Error>{
        let url = rootUrl
        
        let request = PlanRequestParamater()
        request.todoId = todoId
        request.contentTitle = title
        request.contentExplanation = explanation
                
        return restTemplate.postRequestPublisher(url: url, header: JWTHeader(jwtToken), parameters: request)
    }
    
    func getListPublisher(jwtToken: String, todoId: Int) -> AnyPublisher<[ContentResponse], Error>{
        let url = rootUrl
        
        let request = PlanRequestParamater()
        request.todoId = todoId
        
        let header = JWTHeader()
        header.jwtToken = jwtToken
        
        return restTemplate.getRequestPublisher(url: url, header: header, parameters: request)
    }
    
    func getPublisher(jwtToken: String, id: Int) -> AnyPublisher<ContentResponse, Error>{
        let url = rootUrl + "/¥(id)"
        
        return restTemplate.getRequestPublisher(url: url, header: JWTHeader(jwtToken))
    }
    
    func putPublisher(jwtToken: String, id: Int, title:String? = nil, explanation: String? = nil) -> AnyPublisher<VoidResponse, Error>{
        let url = rootUrl + "/¥(id)"
        
        let request = PlanRequestParamater()
        request.contentExplanation = explanation
        request.contentTitle = title
        
        return restTemplate.putRequestPublisher(url: url, header: JWTHeader(jwtToken), parameters: request)
    }
    
    func deletePublisher(jwtToken: String, id: Int) -> AnyPublisher<VoidResponse, Error>{
        let url = rootUrl + "/¥(id)"
        
        return restTemplate.deleteRequestPublisher(url: url, header: JWTHeader(jwtToken))
    }
    
    func putIsCompletedPublisher(jwtToken: String, id: Int, isCompleted: Bool) -> AnyPublisher<VoidResponse, Error>{
        let url = rootUrl + "/¥(id)/is_completed"
        
        let request = PlanRequestParamater()
        request.isCompleted = isCompleted
        
        return restTemplate.putRequestPublisher(url: url, header: JWTHeader(jwtToken), parameters: request)
    }
    
}
