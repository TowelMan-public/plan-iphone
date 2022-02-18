//
//  NotNullValidatable.swift
//  plan-ios
//
//  Created by タオルマン on 2022/02/18.
//

import Foundation

class NotNullValidatable<T>: Validatable<T>{
    private var errorMessage = "必須ですから何か入力・指定してください。"
    
    func setErrorMessage(message: String) -> Self{
        errorMessage = message
        return self
    }
    
    override func validate(_ value: T?) -> String? {
        if value == nil{
            return errorMessage
        }
        
        return nil
    }
}
