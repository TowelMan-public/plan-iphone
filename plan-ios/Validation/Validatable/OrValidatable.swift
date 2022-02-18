//
//  OrValidatable.swift
//  plan-ios
//
//  Created by タオルマン on 2022/02/18.
//

import Foundation

class OrValidatable<T>: Validatable<T>{
    private let validatableArray: [Validatable<T>]
    
    init(@validatableArrayBuilder _ validatableArrayDelegate: () -> [Validatable<T>]){
        validatableArray = validatableArrayDelegate()
    }
    
    init(_ validatableArray: [Validatable<T>]){
        self.validatableArray = validatableArray
    }
    
    override func validate(_ value: T?) -> String? {
        var message: String? = nil
        
        for validatable in validatableArray {
            message = validatable.validate(value)
            if message == nil {
                return nil
            }
        }
        
        return message
    }
}
