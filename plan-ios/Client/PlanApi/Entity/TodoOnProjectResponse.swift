//
//  TodoOnProjectResponse.swift
//  plan-ios
//
//  Created by タオルマン on 2022/02/11.
//

import Foundation

struct TodoOnProjectResponse: Codable {
    let todoOnProjectId: Int
    let projectId: Int
    let todoName: String
    let startDate: Date
    let finishDate: Date
    let isCopyContentsToUsers: Bool
    let isCompleted: Bool
}
