//
//  SelectedInValidatable.swift
//  plan-ios
//
//  Created by タオルマン on 2022/02/18.
//

import Foundation

class SelectedInValidatable<T: Equatable>: Validatable<T> {
    private var errorMessage = "選ばれた値が不正です。"
    private let selectedInValueArray: [T]
    
    init(_ valueArray: [T]){
        selectedInValueArray = valueArray
    }
    
    init(@arrayBuilder value valueArryDelegate: () -> [T]){
        selectedInValueArray = valueArryDelegate()
    }
    
    func setErrorMessage(message: String) -> Self{
        errorMessage = message
        return self
    }
    
    override func validate(_ value: T?) -> String? {
        guard let value = value else {
            return nil
        }

        for selectedInValue in selectedInValueArray {
            if value == selectedInValue{
                break
            }
        }
        
        return errorMessage
    }
    
    @resultBuilder struct arrayBuilder{
        static func buildBlock<T>(_ components: T...) -> [T]{
            var contentArray: [T] = []
            
            for content in components{
                contentArray.append(content)
            }
            
            return contentArray
        }
    }
}
