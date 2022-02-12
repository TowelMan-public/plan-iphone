//
//  Dto.swift
//  plan-ios
//
//  Created by タオルマン on 2022/02/07.
//

import Foundation

class RequestParameters: Codable{
    func getQueryItems(encoder: JSONEncoder, decoder: JSONDecoder) -> [URLQueryItem]{
        var val: [URLQueryItem] = []
        
        if let dataSelf = try? encoder.encode(self),
           let dictionalSelf = try? decoder.decode(Dictionary<String, String>.self, from: dataSelf){
            
            for (key, value) in dictionalSelf {
                val.append(.init(name: key, value: value))
            }
            
        }
        
        return val
    }
}
