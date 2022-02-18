//
//  AndValidatable.swift
//  plan-ios
//
//  Created by タオルマン on 2022/02/18.
//

import Foundation

class AndValidatable<T>: Validatable<T>{
    private let validatableArray: [Validatable<T>]
    
    init(@validatableArrayBuilder _ validatableArrayDelegate: () -> [Validatable<T>]){
        validatableArray = validatableArrayDelegate()
    }
    
    init(_ validatableArray: [Validatable<T>]){
        self.validatableArray = validatableArray
    }
    
    override func validate(_ value: T?) -> String? {
        for validatable in validatableArray {
            if let message = validatable.validate(value){
                return message
            }
        }
        
        return nil
    }
}
