//
//  BaseApi.swift
//  plan-ios
//
//  Created by タオルマン on 2022/02/10.
//

import Foundation

class PlanBaseApi{
    let restTemplate: RestTemplate =
        RestTemplate(responseErrorCreator: ApiResponseErrorCreator(), dateFormatter: .dateFormatForPlan)

}

fileprivate extension DateFormatter{
    
    static let dateFormatForPlan: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-M-d HH:mm"
        formatter.timeZone = TimeZone(secondsFromGMT: 9)
        formatter.locale = Locale(identifier: "ja_JP")
        formatter.calendar = Calendar(identifier: .iso8601)
        return formatter
    }()
}
