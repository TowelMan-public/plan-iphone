//
//  StringSizeRangeValidatable.swift
//  plan-ios
//
//  Created by タオルマン on 2022/02/18.
//

import Foundation

class StringSizeRangeValidatable: Validatable<String>{
    private var maxLessThanSize: Int? = nil
    private var maxLessOrSize: Int? = nil
    private var minMoreOrSize: Int? = nil
    private var minMoreThanSize: Int? = nil
    private var overMaxErrorMessage = "値が大きすぎます"
    private var overMinErrorMessage = "値が小さすぎます"
    
    func max(lessOr: Int? = nil, lessThan: Int? = nil) -> Self {
        maxLessThanSize = lessThan
        maxLessOrSize = lessOr
        
        return self
    }
    
    func min(moreOr: Int? = nil, moreThan: Int? = nil) -> Self{
        minMoreOrSize = moreOr
        minMoreThanSize = moreThan
        
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
    
    override func validate(_ value: String?) -> String?{
        guard let value = value else {
            return nil
        }

        let size = value.count
        
        if let maxLessThanSize = maxLessThanSize,
           maxLessThanSize <= size {
            return overMaxErrorMessage
        }
        
        if let maxLessOrSize = maxLessOrSize,
           maxLessOrSize < size {
            return overMaxErrorMessage
        }
        
        if let minMoreOrSize = minMoreOrSize,
           minMoreOrSize > size {
            return overMinErrorMessage
        }
        
        if let minMoreThanSize = minMoreThanSize,
           minMoreThanSize >= size {
            return overMinErrorMessage
        }
        
        return nil
    }
}
