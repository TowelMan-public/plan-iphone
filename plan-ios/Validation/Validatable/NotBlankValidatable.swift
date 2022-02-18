//
//  NotBlankValidatable.swift
//  plan-ios
//
//  Created by タオルマン on 2022/02/18.
//

import Foundation

class NotBlankValidatable: Validatable<String>{
    private var errorMessage = "必須ですから何か入力してください。"
    
    func setErrorMessage(message: String) -> Self{
        errorMessage = message
        return self
    }
    
    override func validate(_ value: String?) -> String? {
        if value == nil || value?.isEmpty ?? true{
            return errorMessage
        }
        
        return nil
    }
}
