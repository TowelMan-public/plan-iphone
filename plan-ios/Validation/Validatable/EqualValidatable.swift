//
//  EqualValidatable.swift
//  plan-ios
//
//  Created by タオルマン on 2022/02/18.
//

import Foundation

class EqualValidatable<T: Equatable>: Validatable<T>{
    private let equalValueDelegate: () -> T
    private var errorMessage = "この値は他の何かと一緒である必要があります。"
    
    init(_ equalValue: T){
        equalValueDelegate = {
            return equalValue
        }
    }
    
    init(_ equalValueDelegate: @escaping () -> T){
        self.equalValueDelegate = equalValueDelegate
    }
    
    func setErrorMessage(message: String) -> Self{
        errorMessage = message
        return self
    }
    
    override func validate(_ value: T?) -> String? {
        if let value = value,
           value != equalValueDelegate(){
            return errorMessage
        }
        
        return nil
    }
}
