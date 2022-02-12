//
//  PlanApi.swift
//  plan-ios
//
//  Created by タオルマン on 2022/02/10.
//

import Foundation

class PlanApi{
    static var v1: V1 {
        return V1()
    }
    
    static var last: V1{
        get{
            return Self.v1
        }
    }
}

class PlanApiURL{
    static let ROOT_URL = "http://localhost:8080/"
    static let V1_ROOT_URL = ROOT_URL + "v1/"
}
