//
//  JWTHeader.swift
//  plan-ios
//
//  Created by タオルマン on 2022/02/09.
//

import Foundation

class JWTHeader: Header{
    var jwtToken: String?
    
    init(_ jwtToken: String? = nil){
        self.jwtToken = jwtToken
    }
    
    override func setHeaderToRequest(_ request: inout URLRequest) {
        if let jwtToken = self.jwtToken{
            request.addValue(jwtToken, forHTTPHeaderField: "X-AUTH-TOKEN")
        }
        
        super.setHeaderToRequest(&request)
    }
}
