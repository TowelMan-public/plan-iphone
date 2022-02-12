//
//  UserConfigResponse.swift
//  plan-ios
//
//  Created by タオルマン on 2022/02/11.
//

import Foundation

struct UserConfigResponse: Codable {
    let beforeDeadlineForTodoNotice: Int
    let beforeDeadlineForProjectNotice: Int
    let isPushInsertedTodoNotice: Bool
    let isPushInsertedStartedTodoNotice: Bool
}
