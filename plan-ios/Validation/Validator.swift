//
//  Validator.swift
//  plan-ios
//
//  Created by タオルマン on 2022/02/18.
//

import Foundation
import Combine

class AnyValidator{
    private(set) var errorMessage: String?
    private var setErrorMessageDelegate: ((String) -> Void)?
    
    func validate() -> Bool {
        return true
    }
    
    func validatePublisher() -> AnyPublisher<Bool, Never> {
        return DeferredFuture{ promis in
            promis(.success(true))
        }
    }
    
    func assignErrorMessage<Root>(to keyPath: ReferenceWritableKeyPath<Root, String>, on object: Root) -> Self{
        setErrorMessageDelegate = {message in
            object[keyPath: keyPath] = message
        }
        
        return self
    }
    
    func assignErrorMessage(_ delegate: @escaping (String) -> Void) -> Self{
        setErrorMessageDelegate = delegate
        return self
    }
    
    func setErrorMessage(_ message: String){
        errorMessage = message
        setErrorMessageDelegate?(message)
    }
}

class Validator<T>: AnyValidator{
    private let validatableArray: [Validatable<T>]
    let valuePublisher: AnyPublisher<T, Never>
    private(set) var canselable: AnyCancellable? = nil
    
    init(_ publicher: AnyPublisher<T, Never>, @validatableArrayBuilder _ validatableArrayDelegate: () -> [Validatable<T>]){
        valuePublisher = publicher
        validatableArray = validatableArrayDelegate()
    }
    
    init(_ publicher: AnyPublisher<T, Never>){
        valuePublisher = publicher
        validatableArray = []
    }
    
    init(_ value: T, @validatableArrayBuilder _ validatableArrayDelegate: () -> [Validatable<T>]){
        valuePublisher = DeferredFuture{ promis in
            promis(.success(value))
        }
        validatableArray = validatableArrayDelegate()
    }
    
    init(_ value: T){
        valuePublisher = DeferredFuture{ promis in
            promis(.success(value))
        }
        validatableArray = []
    }
    
    override func validate() -> Bool {
        var result = true
        
        canselable = valuePublisher
            .sink(receiveValue: { value in
                for validatable in self.validatableArray {
                    if let errorMessage = validatable.validate(value){
                        self.setErrorMessage(errorMessage)
                        result = false
                        return
                    }
                }
            })
        
        return result
    }
    
    override func validatePublisher() -> AnyPublisher<Bool, Never> {
        return valuePublisher
            .map{value -> Bool in
                for validatable in self.validatableArray {
                    if let errorMessage = validatable.validate(value){
                        self.setErrorMessage(errorMessage)
                        return false
                    }
                }
                return false
            }
            .eraseToAnyPublisher()
    }
}

@resultBuilder struct validatorArrayBuilder{
    static func buildBlock(_ components: AnyValidator...) -> [AnyValidator]{
        var contentArray: [AnyValidator] = []
        
        for content in components{
            contentArray.append(content)
        }
        
        return contentArray
    }
}
