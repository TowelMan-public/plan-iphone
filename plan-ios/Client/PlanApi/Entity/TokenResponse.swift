//
//  TokenResponse.swift
//  plan-ios
//
//  Created by タオルマン on 2022/02/11.
//

import Foundation

struct TokenResponse: Codable{
    let refreshToken: String
    let authenticationToken: String
}
