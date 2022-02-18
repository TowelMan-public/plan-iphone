//
//  IfValidatable.swift
//  plan-ios
//
//  Created by タオルマン on 2022/02/18.
//

import Foundation

class IfValidatable<T>: Validatable<T>{
    private let conditionsDelegate: (T?) -> Bool
    private let validatableArray: [Validatable<T>]
    private var elseValidatableArray: [Validatable<T>] = []
    
    init(_ conditionsDelegate: @escaping (T?) -> Bool, @validatableArrayBuilder _ validatableArrayDelegate: () -> [Validatable<T>]){
        self.conditionsDelegate = conditionsDelegate
        validatableArray = validatableArrayDelegate()
    }
    
    init(_ conditionsDelegate: @escaping (T?) -> Bool, _ validatableArray: [Validatable<T>]){
        self.conditionsDelegate = conditionsDelegate
        self.validatableArray = validatableArray
    }
    
    func elseValidatable(@validatableArrayBuilder _ validatableArrayDelegate: () -> [Validatable<T>]) -> Self{
        elseValidatableArray = validatableArrayDelegate()
        return self
    }
    
    func elseValidatable(_ validatableArray: [Validatable<T>]) -> Self{
        elseValidatableArray = validatableArray
        return self
    }
    
    func elseIfValidatable(_ conditionsDelegate: @escaping (T?) -> Bool, @validatableArrayBuilder _ validatableArrayDelegate: () -> [Validatable<T>]) -> IfValidatable<T>{
        let validatable = IfValidatable(conditionsDelegate, validatableArrayDelegate)
        elseValidatableArray = [validatable]
        return validatable
    }

    func elseIfValidatable(_ conditionsDelegate: @escaping (T?) -> Bool, _ validatableArray: [Validatable<T>]) -> IfValidatable<T>{
        let validatable = IfValidatable(conditionsDelegate, validatableArray)
        elseValidatableArray = [validatable]
        return validatable
    }
    
    override func validate(_ value: T?) -> String? {
        for validatable in conditionsDelegate(value) ? validatableArray : elseValidatableArray{
            if let message = validatable.validate(value) {
                return message
            }
        }
        
        return nil
    }
}
