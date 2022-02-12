//
//  TodoOnResponsibleResponse.swift
//  plan-ios
//
//  Created by タオルマン on 2022/02/11.
//

import Foundation

struct TodoOnResponsibleResponse: Codable {
    let todoOnProjectId: Int
    let todoName: String
    let todoOnResponsibleId: Int
    let projectId: Int
    let isCompleted: Bool
    let startDate: Date
    let finishDate: Date
}
