//
//  ContentResponse.swift
//  plan-ios
//
//  Created by タオルマン on 2022/02/10.
//

import Foundation

struct ContentResponse: Codable{
    let contentId: Int
    let todoId: Int
    let contentTitle: String
    let contentExplanation: String
    let isCompleted: Bool
}
