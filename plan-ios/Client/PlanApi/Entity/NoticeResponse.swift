//
//  NoticeResponse.swift
//  plan-ios
//
//  Created by タオルマン on 2022/02/10.
//

import Foundation

struct NoticeResponse: Codable{
    let messgae: String
    let id: Int
    let noticeType: NoticeType
}

enum NoticeType: String, CaseIterable, Codable{
    case todo = "TODO_NOTICE"
    case project = "PROJECT_NOTICE"
}
