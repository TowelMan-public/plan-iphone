//
//  NoticeV1.swift
//  plan-ios
//
//  Created by タオルマン on 2022/02/12.
//

import Foundation
import Combine

class NoticeV1: PlanBaseApi{
    private let rootUrl = PlanApiURL.V1_ROOT_URL + "notice"
    
    func getListPublisher(jwtToken: String) -> AnyPublisher<[NoticeResponse], Error>{
        let url = rootUrl
        
        return restTemplate.getRequestPublisher(url: url, header: JWTHeader(jwtToken))
    }
}
