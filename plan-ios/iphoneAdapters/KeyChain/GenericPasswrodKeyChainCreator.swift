//
//  GenericPasswrodKeyChainCreator.swift
//  plan-ios
//
//  Created by タオルマン on 2022/02/14.
//

import Foundation

class GenericPasswrodKeyChainCreator{
    private let key: String
    private var dateFormatter: DateFormatter?
    
    init(key: String){
        self.key = key
    }
    
    func setDateFormatter(dateFormatter: DateFormatter) -> Self{
        self.dateFormatter = dateFormatter
        return self
    }
    
    func create<ValueType: Codable>(valueId: String) -> GenericPasswrodKeyChain<ValueType>{
        return GenericPasswrodKeyChain(key: key, valueId: valueId, dateFormatter: dateFormatter)
    }
}
