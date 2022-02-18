//
//  ValidationManager.swift
//  plan-ios
//
//  Created by タオルマン on 2022/02/18.
//

import Foundation
import Combine

class ValidateManager {
    private let validatorArray: [AnyValidator]
    private(set) var isAllPassed: Bool = false
    private var setIsAllPassedDelegate: ((Bool) -> Void)?
    
    init(_ validatorArray: [AnyValidator]){
        self.validatorArray = validatorArray
    }
    
    init(@validatorArrayBuilder _ validatorArrayDelegate: () -> [AnyValidator]) {
        self.validatorArray = validatorArrayDelegate()
    }
    
    func assignIsAllPassed<Root>(to keyPath: ReferenceWritableKeyPath<Root, Bool>, on object: Root) -> Self{
        setIsAllPassedDelegate = {isAllPassed in
            object[keyPath: keyPath] = isAllPassed
        }
        
        return self
    }
    
    func assignIsAllPassed(_ delegate: @escaping (Bool) -> Void) -> Self{
        setIsAllPassedDelegate = delegate
        return self
    }
    
    private func setIsAllPassed(_ isAllPassed: Bool){
        self.isAllPassed = isAllPassed
        setIsAllPassedDelegate?(isAllPassed)
    }
    
    func validate() -> Bool{
        var isAllPassed = true
        
        for validator in validatorArray{
            if !validator.validate(){
                isAllPassed = false
            }
        }
        
        setIsAllPassed(isAllPassed)
        return isAllPassed
    }
    
    func validatePublisher() -> AnyCancellable?{
        if validatorArray.isEmpty{
            return nil
        }
        
        var publisherArray: [AnyPublisher<Bool, Never>] = []
        for validator in validatorArray{
            publisherArray.append(validator.validatePublisher())
        }
        
        while publisherArray.count != 1 {
            var index = 0
            var publisherArrayTmp: [AnyPublisher<Bool, Never>] = []
            
            while publisherArray.count - 1 - index > 1 {
                publisherArrayTmp.append(
                    publisherArray[index]
                        .combineLatest(publisherArray[index + 1])
                        .map{
                            return $0.0 && $0.1
                        }
                        .eraseToAnyPublisher()
                )
                index += 2
            }
            
            publisherArray = publisherArrayTmp
        }
        
        return publisherArray[0]
            .sink(receiveValue: {isAllPassed in
                self.setIsAllPassed(isAllPassed)
            })
    }
}
