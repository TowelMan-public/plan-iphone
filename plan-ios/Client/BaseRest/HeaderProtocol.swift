//
//  Header.swift
//  plan-ios
//
//  Created by タオルマン on 2022/02/07.
//

import Foundation

class Header{
    
    var contentType: String = "application/json"
    
    func setHeaderToRequest(_ request: inout URLRequest){
        request.addValue(contentType, forHTTPHeaderField: "Content-Type")
    }
}
