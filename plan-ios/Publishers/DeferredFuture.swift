//
//  PublisheDeferred.swift
//  plan-ios
//
//  Created by タオルマン on 2022/02/07.
//

import Combine

func DeferredFuture<ResultType, ErrorType>(_ attemptToFulfill: @escaping (@escaping Future<ResultType, ErrorType>.Promise) -> Void) -> AnyPublisher<ResultType, ErrorType> where ErrorType : Error {
    return Deferred{
        Future(attemptToFulfill)
    }
    .eraseToAnyPublisher()
}
