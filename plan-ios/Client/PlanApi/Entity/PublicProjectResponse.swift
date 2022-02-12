//
//  PublicProjectResponse.swift
//  plan-ios
//
//  Created by タオルマン on 2022/02/11.
//

import Foundation

struct PublicProjectResponse: Codable{
    let publicProjectId: Int
    let projectName: String
    let startDate: Date
    let finishDate: Date
    let isCompleted: Bool
    let projectAuthorityId: ProjectAuthority
}

enum ProjectAuthority: Int, CaseIterable, Codable {
    case normal = 1
    case master = 2
    case tentative = 3
}
