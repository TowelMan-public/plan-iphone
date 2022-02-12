//
//  PublicProjectV1.swift
//  plan-ios
//
//  Created by タオルマン on 2022/02/12.
//

import Foundation
import Combine

class PublicProjectV1: PlanBaseApi{
    private let rootUrl = PlanApiURL.V1_ROOT_URL + "project"
    
    func postPublisher(jwtToken: String, name: String, startDate: Date, finishDate: Date) -> AnyPublisher<Int, Error>{
        let url = rootUrl
        
        let request = PlanRequestParamater()
        request.projectName = name
        request.startDate = startDate
        request.finishDate = finishDate
        
        return restTemplate.postRequestPublisher(url: url, header: JWTHeader(jwtToken), parameters: request)
    }
    
    func getPublisher(jwtToken: String, id: Int) -> AnyPublisher<PublicProjectResponse, Error>{
        let url = rootUrl + "/¥(id)"
        
        return restTemplate.getRequestPublisher(url: url, header: JWTHeader(jwtToken))
    }
    
    func getListPublisher(jwtToken: String) -> AnyPublisher<[PublicProjectResponse], Error>{
        let url = rootUrl
        
        return restTemplate.getRequestPublisher(url: url, header: JWTHeader(jwtToken))
    }
    
    func putPublisher(jwtToken: String, id: Int, name: String? = nil, startDate: Date? = nil, finishDate: Date? = nil) -> AnyPublisher<VoidResponse, Error>{
        let url = rootUrl + "/¥(id)"
        
        let request = PlanRequestParamater()
        request.projectName = name
        request.startDate = startDate
        request.finishDate = finishDate
        
        return  restTemplate.putRequestPublisher(url: url, header: JWTHeader(jwtToken), parameters: request)
    }
    
    func deletePublisher(jwtToken: String, id: Int) -> AnyPublisher<VoidResponse, Error>{
        let url = rootUrl + "/¥(id)"
        
        return restTemplate.deleteRequestPublisher(url: url, header: JWTHeader(jwtToken))
    }
    
    func getSolicitedPublisher(jwtToken: String) -> AnyPublisher<PublicProjectResponse, Error>{
        let url = rootUrl + "/solicited"
        
        return restTemplate.getRequestPublisher(url: url, header: JWTHeader(jwtToken))
    }
    
    func postIsCompletedPublisher(jwtToken: String, id: Int, isCompleted: Bool) -> AnyPublisher<VoidResponse, Error>{
        let url = rootUrl + "/¥(id)/is_completed"
        
        let request = PlanRequestParamater()
        request.isCompleted = isCompleted
        
        return restTemplate.postRequestPublisher(url: url, header: JWTHeader(jwtToken))
    }
}
