//
//  UserInTodoOnResponsibleResponse.swift
//  plan-ios
//
//  Created by タオルマン on 2022/02/11.
//

import Foundation

struct UserInTodoOnResponsibleResponse: Codable {
    let todoOnProjectId: Int
    let isCompleted: Bool
    let userName: String
}
