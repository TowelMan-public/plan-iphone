//
//  Dto.swift
//  plan-ios
//
//  Created by タオルマン on 2022/02/07.
//

import Foundation

class RequestParameters: Codable{
    private var paramaters: [String: String] = [:]
    
    var queryItems: [URLQueryItem]{
        get{
            var val: [URLQueryItem] = []
            for (key, value) in self.paramaters {
                val.append(.init(name: key, value: value))
            }
            
            return val
        }
    }
    
    func setValue<T>(key: String, value: T) where T : LosslessStringConvertible {
        self.paramaters[key] = String(value)
    }
}
