//
//  RangeValidatable.swift
//  plan-ios
//
//  Created by タオルマン on 2022/02/18.
//

import Foundation

class RangeValidatable<T: Comparable>: Validatable<T>{
    
    private var maxLessThanValue: T? = nil
    private var maxLessOrValue: T? = nil
    private var minMoreOrValue: T? = nil
    private var minMoreThanValue: T? = nil
    private var overMaxErrorMessage = "値が大きすぎます"
    private var overMinErrorMessage = "値が小さすぎます"
    
    func max(lessOr: T? = nil, lessThan: T? = nil) -> Self {
        maxLessThanValue = lessThan
        maxLessOrValue = lessOr
        
        return self
    }
    
    func min(moreOr: T? = nil, moreThan: T? = nil) -> Self{
        minMoreOrValue = moreOr
        minMoreThanValue = moreThan
        
        return self
    }
    
    func setOverMaxErrorMessage(message: String) -> Self{
        overMaxErrorMessage = message
        return self
    }
    
    func setOverMinErrorMessage(message: String) -> Self{
        overMinErrorMessage = message
        return self
    }
    
    override func validate(_ value: T?) -> String?{
        guard let value = value else {
            return nil
        }

        if let maxLessThanValue = maxLessThanValue,
           maxLessThanValue <= value{
            return overMaxErrorMessage
        }
        
        if let maxLessOrValue = maxLessOrValue,
           maxLessOrValue < value{
            return overMaxErrorMessage
        }
        
        if let minMoreOrValue = minMoreOrValue,
           minMoreOrValue > value{
            return overMinErrorMessage
        }
        
        if let minMoreThanValue = minMoreThanValue,
           minMoreThanValue >= value {
            return overMinErrorMessage
        }
        
        return nil
    }
}
