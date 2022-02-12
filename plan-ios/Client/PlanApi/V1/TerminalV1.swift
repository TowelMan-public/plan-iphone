//
//  TerminalV1.swift
//  plan-ios
//
//  Created by タオルマン on 2022/02/12.
//

import Foundation
import Combine

class TerminalV1: PlanBaseApi{
    private let rootUrl = PlanApiURL.V1_ROOT_URL + "user/terminal"
    
    func postPublisher(jwtToken: String, name: String) -> AnyPublisher<VoidResponse, Error>{
        let request = PlanRequestParamater()
        request.terminalName = name
        
        return restTemplate.postRequestPublisher(url: rootUrl, header: JWTHeader(jwtToken), parameters: request)
    }
    
    func getListPublisher(jwtToken: String) -> AnyPublisher<[TerminalResponse], Error>{
        return restTemplate.getRequestPublisher(url: rootUrl, header: JWTHeader(jwtToken))
    }
    
    func putPublisher(jwtToken: String, oldName: String, newName: String) -> AnyPublisher<VoidResponse, Error>{
        let request = PlanRequestParamater()
        request.newTerminalName = newName
        request.oldTerminalName = oldName
        
        return restTemplate.putRequestPublisher(url: rootUrl, header: JWTHeader(jwtToken), parameters: request)
    }
    
    func deletePublisher(jwtToken: String, name: String) -> AnyPublisher<VoidResponse, Error>{
        let request = PlanRequestParamater()
        request.terminalName = name
        
        return restTemplate.deleteRequestPublisher(url: rootUrl, header: JWTHeader(jwtToken), parameters: request)
    }
}
