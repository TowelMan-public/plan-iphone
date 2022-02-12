//
//  TodoV1.swift
//  plan-ios
//
//  Created by タオルマン on 2022/02/12.
//

import Foundation
import Combine

class TodoV1: PlanBaseApi{
    private let rootUrl = PlanApiURL.V1_ROOT_URL + "todo"
    
    func postPublisher(jwtToken: String, projectId: Int, name: String, startDate: Date, finishDate: Date, isCopyContentsToUsers: Bool) -> AnyPublisher<Int, Error>{
        let request = PlanRequestParamater()
        request.projectId = projectId
        request.todoName = name
        request.startDate = startDate
        request.finishDate = finishDate
        request.isCopyContentsToResponsible = isCopyContentsToUsers
        
        return restTemplate.postRequestPublisher(url: rootUrl, header: JWTHeader(jwtToken), parameters: request)
    }
    
    func getListByExamplePublisher(jwtToken: String, projectId: Int? = nil, startDate: Date? = nil, finishDate: Date? = nil, isPrivateProjectOnly: Bool = false, isIncludeCompletedTodo: Bool = false) -> AnyPublisher<[TodoOnProjectResponse], Error>{
        let request = PlanRequestParamater()
        request.projectId = projectId
        request.isInPrivateProjectOnly = isPrivateProjectOnly
        request.isIncludeCompletedTodo = isIncludeCompletedTodo
        request.startDate = startDate
        request.finishDate = finishDate
        
        return restTemplate.getRequestPublisher(url: rootUrl, header: JWTHeader(jwtToken), parameters: request)
    }
    
    func getPublisher(jwtToken: String, id: Int) -> AnyPublisher<TodoOnProjectResponse, error>{
        let url = rootUrl + "/¥(id)"
        
        return restTemplate.getRequestPublisher(url: url, header: JWTHeader(jwtToken))
    }
    
    func putPublisher(jwtToken: String, id: Int, name: String? = nil, startDate: Date? = nil, finishDate: Date? = nil, isCopyContentsToUsers: Bool? = nil) -> AnyPublisher<VoidResponse, Error>{
        let url = rootUrl + "/¥(id)"
        
        let request = PlanRequestParamater()
        request.todoName = name
        request.startDate = startDate
        request.finishDate = finishDate
        request.isCopyContentsToResponsible = isCopyContentsToUsers
        
        return restTemplate.putRequestPublisher(url: url, header: JWTHeader(jwtToken), parameters: request)
    }
    
    func deletePublisher(jwtToken: String, id: Int) -> AnyPublisher<VoidResponse, Error>{
        let url = rootUrl + "/¥(id)"
        
        return restTemplate.deleteRequestPublisher(url: url, header: JWTHeader(jwtToken))
    }
    
    func putIsCompletedPublisher(jwtToken: String, id: Int, isCompleted: Bool) -> AnyPublisher<VoidResponse, Error>{
        let url = "/¥(id)/is_completed"
        
        let request = PlanRequestParamater()
        request.isCompleted = isCompleted
        
        return restTemplate.putRequestPublisher(url: url, header: JWTHeader(jwtToken), parameters: request)
    }
}
