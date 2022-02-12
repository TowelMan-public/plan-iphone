//
//  RestTemplate.swift
//  plan-ios
//
//  Created by タオルマン on 2022/02/07.
//

import Foundation
import Combine

class RestTemplate{

    private let decorder: JSONDecoder = JSONDecoder()
    private let encorder: JSONEncoder = JSONEncoder()
    private var responseErrorCreator: ResponseErrorCreator
    
    init(responseErrorCreator: ResponseErrorCreator = ResponseErrorCreator(), dateFormatter: DateFormatter?) {
        self.responseErrorCreator = responseErrorCreator
        
        if let dateFormatter = dateFormatter {
            decorder.dateDecodingStrategy = .formatted(dateFormatter)
            encorder.dateEncodingStrategy = .formatted(dateFormatter)
            
        }
    }
        
    func getRequestPublisher<ResponseType: Codable>(url: String, header: Header = Header(), parameters: RequestParameters = RequestParameters()) -> AnyPublisher<ResponseType, Error>{
        
        return self.requestPublisher(method: .get, url: url, header: header, parameters: parameters)
    }
    
    func postRequestPublisher<ResponseType: Codable>(url: String, header: Header = Header(), parameters: RequestParameters = RequestParameters()) -> AnyPublisher<ResponseType, Error>{
        
        return self.requestPublisher(method: .post, url: url, header: header, parameters: parameters)
    }
    
    func putRequestPublisher<ResponseType: Codable>(url: String, header: Header = Header(), parameters: RequestParameters = RequestParameters()) -> AnyPublisher<ResponseType, Error>{
        
        return self.requestPublisher(method: .put, url: url, header: header, parameters: parameters)
    }
    
    func deleteRequestPublisher<ResponseType: Codable>(url: String, header: Header = Header(), parameters: RequestParameters = RequestParameters()) -> AnyPublisher<ResponseType, Error>{
        
        return self.requestPublisher(method: .delete, url: url, header: header, parameters: parameters)
    }
    
    private func requestPublisher<ResponseType: Codable>(method: Method, url: String, header: Header, parameters: RequestParameters) -> AnyPublisher<ResponseType, Error>{
        
        return DeferredFuture{callback in
            
            guard let urlObject = URL(string: url) else{
                callback(.failure(RestTemplateError.urlLllegal))
                return
            }
            var urlComponents = URLComponents(url: urlObject, resolvingAgainstBaseURL: true)!
            if method == .get {
                urlComponents.queryItems = parameters.getQueryItems(encoder: self.encorder, decoder: self.decorder)
            }
            
            var request = URLRequest(url: urlComponents.url!)
            request.httpMethod = method.rawValue
            header.setHeaderToRequest(&request)
            if method != .get {
                guard let httpBody = try? self.encorder.encode(parameters) else {
                    callback(.failure(RestTemplateError.requestParametersLllegal))
                    return
                }
                request.httpBody = httpBody
            }
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                
                if let error = self.responseErrorCreator.createError(responseData: data, response: response, error: error, decorder: self.decorder) {
                    callback(.failure(error))
                }
                
                if let data = data, let responseObject = try? self.decorder.decode(ResponseType.self, from: data) {
                    callback(.success(responseObject))
                }else{
                    callback(.failure(RestTemplateError.parseError))
                }
                                
            }
            .resume()
        }
    }
    
    private enum Method: String{
        case post = "POST"
        case get = "GET"
        case put = "PUT"
        case delete = "DELETE"
    }
}

enum RestTemplateError: Error{
    case parseError
    case requestParametersLllegal
    case urlLllegal
}
