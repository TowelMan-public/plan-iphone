//
//  Validatable.swift
//  plan-ios
//
//  Created by タオルマン on 2022/02/18.
//

import Foundation

class Validatable<T>{
    func validate(_ value: T?) -> String?{
        return nil
    }
}

@resultBuilder struct validatableArrayBuilder{
    static func buildBlock<T>(_ components: Validatable<T>...) -> [Validatable<T>]{
        var contentArray: [Validatable<T>] = []
        
        for content in components{
            contentArray.append(content)
        }
        
        return contentArray
    }
}
