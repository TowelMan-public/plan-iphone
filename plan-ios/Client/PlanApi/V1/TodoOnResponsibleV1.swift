//
//  TodoOnResponsibleV1.swift
//  plan-ios
//
//  Created by タオルマン on 2022/02/12.
//

import Foundation
import Combine

class TodoOnResponsibleV1: PlanBaseApi{
    private let rootUrl = PlanApiURL.V1_ROOT_URL + "todo"
    
    private func createRootUrl(todoOnProjectId: Int) -> String {
        return PlanApiURL.V1_ROOT_URL + "todo/¥(todoOnProjectId)/responsible"
    }
    
    func postPublisher(jwtToken: String, todoOnProjectId: Int, userName: String) -> AnyPublisher<VoidResponse, Error>{
        let url = createRootUrl(todoOnProjectId: todoOnProjectId) + "/¥(userName)"
        
        return restTemplate.postRequestPublisher(url: url, header: JWTHeader(jwtToken))
    }
    
    func getListInTodoPublisher(jwtToken: String, todoOnProjectId: Int) -> AnyPublisher<[UserInTodoOnResponsibleResponse], Error>{
        return restTemplate.getRequestPublisher(url: createRootUrl(todoOnProjectId: todoOnProjectId), header: JWTHeader(jwtToken))
    }
    
    func deletePublisher(jwtToken: String, todoOnProjectId: Int, userName: String) -> AnyPublisher<VoidResponse, Error>{
        let url = createRootUrl(todoOnProjectId: todoOnProjectId) + "/¥(userName)"
        
        return restTemplate.deleteRequestPublisher(url: url, header: JWTHeader(jwtToken))
    }
    
    func postExitPublisher(jwtToken: String, todoOnProjectId: Int) -> AnyPublisher<VoidResponse, Error>{
        let url = createRootUrl(todoOnProjectId: todoOnProjectId) + "/exit"
        
        return restTemplate.postRequestPublisher(url: url, header: JWTHeader(jwtToken))
    }
    
    func getListByExamplePublisher(jwtToken: String, publicProjectId: Int? = nil, startDate: Date? = nil, finishDate: Date? = nil, isIncludeCompleted: Bool? = nil) -> AnyPublisher<[TodoOnResponsibleResponse], Error>{
        let url = rootUrl + "/responsible_todo"
        
        let request = PlanRequestParamater()
        request.publicProjectId = publicProjectId
        request.startDate = startDate
        request.finishDate = finishDate
        request.isIncludeCompletedTodo = isIncludeCompleted
        
        return restTemplate.getRequestPublisher(url: url, header: JWTHeader(jwtToken), parameters: request)
    }
    
    func getPublisher(jwtToken: String, todoOnProjectId: Int) -> AnyPublisher<TodoOnResponsibleResponse, Error>{
        return restTemplate.getRequestPublisher(url: createRootUrl(todoOnProjectId: todoOnProjectId), header: JWTHeader(jwtToken))
    }
    
    func putIsCompletedPublisher(jwtToken: String, todoOnProjectId: Int, isCompleted: Bool, isMyResponsible: Bool = true) -> AnyPublisher<VoidResponse, Error>{
        var url = createRootUrl(todoOnProjectId: todoOnProjectId) + "is_completed"
        
        if !isMyResponsible{
            url += "/all"
        }
        
        return restTemplate.putRequestPublisher(url: url, header: JWTHeader(jwtToken))
    }
}
