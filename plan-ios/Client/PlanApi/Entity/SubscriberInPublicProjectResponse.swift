//
//  SubscriberInPublicProjectResponse.swift
//  plan-ios
//
//  Created by タオルマン on 2022/02/11.
//

import Foundation

struct SubscriberInPublicProjectResponse: Codable {
    let publicProjectId: Int
    let userName: String
    let authorityId: ProjectAuthority
}
