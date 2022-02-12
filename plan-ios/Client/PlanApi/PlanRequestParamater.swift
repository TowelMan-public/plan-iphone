//
//  PlanRequestParamater.swift
//  plan-ios
//
//  Created by タオルマン on 2022/02/10.
//

import Foundation

class PlanRequestParamater: RequestParameters{
    
    var projectId: Int?
    
    var todoId: Int?
    
    var todoOnProjectId: Int?
    
    var contentTitle: String?
    
    var contentExplanation: String?
    
    var isCompleted: Bool?
    
    var terminalName: String?
    
    var projectName: String?
    
    var finishDate: Date?
    
    var startDate: Date?
    
    var publicProjectId: Int?
    
    var userName: String?
    
    var isIncludeCompletedTodo: Bool?
    
    var authorityId: Int?
    
    var todoName: String?
    
    var isCopyContentsToResponsible: Bool?
    
    var isInPrivateProjectOnly: Bool?
    
    var beforeDeadlineForTodoNotice: Int?
    
    var beforeDeadlineForProjectNotice: Int?
    
    var pushInsertedTodoNotice: Bool?
    
    var isPushStartedTodoNotice: Bool?
    
    var userNickName: String?
    
    var password: String?
    
    var refreshJwtToken: String?
    
    var oldTerminalName: String?
    
    var newTerminalName: String?
    
}
