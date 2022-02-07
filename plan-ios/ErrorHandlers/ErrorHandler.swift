//
//  ErrorHandler.swift
//  plan-ios
//
//  Created by タオルマン on 2022/02/07.
//

import Foundation

///エラーハンドラー
class ErrorHandler{
    private var receiverList: [BaseErrorHandlerInner] = []
    private var receiveOn: DispatchQueue = DispatchQueue.global(qos: .userInitiated)
    
    
    /// ErrorTypeに指定されたErrorクラスに対して実行したい処理を指定する。
    /// -
    /// - Returns: 本クラス
    func handle<ErrorType: Error>(receiver: @escaping (ErrorType, ErrorHandlingState) -> Void) -> ErrorHandler{
        self.receiverList.append(
            ErrorHandlerInner<ErrorType>(errorReceive: receiver, receiveOn: self.receiveOn))
        return self
    }
    
    func receive(on: DispatchQueue) -> ErrorHandler {
        self.receiveOn = on
        return self
    }
    
    func run(error: Error){
        for receiver in receiverList.reversed() {
            if !receiver.run(error: error).isPromiseRunNext{
                break
            }
        }
    }
}

///
///　エラーハンドラー内で使用するインナー
///　-typeparamater
///　    -ErrorType: 本クラスが処理するべきErrorクラスのタイプ
///
fileprivate class ErrorHandlerInner<ErrorType: Error>: BaseErrorHandlerInner{
    private let receiveOn: DispatchQueue
    private let errorReceive: (ErrorType, ErrorHandlingState) -> Void
    
    
    /// 初期化をする
    /// - Parameters:
    ///   - errorReceive: 本クラスに紐づけるべき処理
    ///   - receiveOn: 本クラスに紐づけた処理を実行するスコープ
    init(errorReceive: @escaping (ErrorType, ErrorHandlingState) -> Void, receiveOn: DispatchQueue) {
        self.errorReceive = errorReceive
        self.receiveOn = receiveOn
    }
    
    func run(error: Error) -> ErrorHandlingState{
        let state = ErrorHandlingState()
        
        if error is ErrorType {
            self.receiveOn.sync {
                errorReceive(error as! ErrorType, state)
            }
        }else{
            state.promiseRunNext()
        }
        
        return state
    }
}

///
///　エラーハンドラー内で使用する抽象的なインナー
///　一つのErrorクラスに対し、処理する内容などを紐づけて扱う。
///
fileprivate protocol BaseErrorHandlerInner{
    
    /// 本クラスに紐づけられた処理を実行する
    /// errorに指定されたErrorクラスが本クラスに適合しない場合は無視する。
    /// - paramater
    ///    -error: 発生したエラー
    /// - Returns: 処理を実行した際の状態を返す。
    func run(error: Error) -> ErrorHandlingState
}

///
///　エラーハンドリングする際の状態
///
class ErrorHandlingState{
    ///
    ///　次のエラーハンドラーのインナーを実行するかどうか
    ///
    fileprivate var isPromiseRunNext: Bool = false
    
    fileprivate init(){}
    
    ///
    ///　次のエラーハンドラーを実行するように設定する
    ///
    func promiseRunNext() {self.isPromiseRunNext = true}
}
