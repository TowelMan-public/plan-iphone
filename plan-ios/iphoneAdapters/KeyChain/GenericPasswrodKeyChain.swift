//
//  KeyChain.swift
//  plan-ios
//
//  Created by タオルマン on 2022/02/14.
//

import Foundation

class GenericPasswrodKeyChain<ValueType: Codable>{
    private let key: String
    private let valueId: String
    private let decorder: JSONDecoder = JSONDecoder()
    private let encorder: JSONEncoder = JSONEncoder()
    
    init(key: String, valueId: String, dateFormatter: DateFormatter? = nil){
        self.key = key
        self.valueId = valueId
        if let dateFormatter = dateFormatter {
            decorder.dateDecodingStrategy = .formatted(dateFormatter)
            encorder.dateEncodingStrategy = .formatted(dateFormatter)
            
        }
    }
    
    var isFind: Bool{
        return (try? get()) != nil
    }
    
    func get() throws -> ValueType{
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrServer as String: key,
            kSecAttrAccount as String: valueId,
            kSecMatchLimit as String: kSecMatchLimitOne,
            kSecReturnAttributes as String: true,
            kSecReturnData as String: true
        ]
        
        var item: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &item)
        switch status {
            
        case errSecSuccess:
            guard let item = item, let value = item[kSecValueData as String] as? Data else {
                throw KeyChainError.getDataFailure
            }
            
            if let valueObject = try? decorder.decode(ValueType.self, from: value){
                return valueObject
            }else{
                throw KeyChainError.parseError
            }
        
        case errSecItemNotFound:
            throw KeyChainError.notFound
            
        default:
            throw KeyChainError.unkown(getErrorMessageForOSStatus(status))
        }
    }
    
    func set(value: ValueType) throws{
        guard let valData = try? encorder.encode(value) else{
            throw KeyChainError.parseError
        }
        
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrServer as String: key,
            kSecAttrAccount as String: valueId,
            kSecValueData as String: valData,
        ]
        
        let status = SecItemCopyMatching(query as CFDictionary, nil)
        switch status{
            
        case errSecItemNotFound:
            SecItemAdd(query as CFDictionary, nil)
        case errSecSuccess:
            SecItemUpdate(query as CFDictionary,
                          [kSecValueData as String: valData] as CFDictionary)
        default:
            throw KeyChainError.unkown(getErrorMessageForOSStatus(status))
        }
    }
    
    func delete() throws{
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrServer as String: key,
            kSecAttrAccount as String: valueId,
        ]
        
        let status = SecItemCopyMatching(query as CFDictionary, nil)
        switch status {
            
        case errSecSuccess:
            SecItemDelete(query as CFDictionary)
        case errSecItemNotFound:
            return
        default:
            throw KeyChainError.unkown(getErrorMessageForOSStatus(status))
        }
    }
    
    private func getErrorMessageForOSStatus(_ status: OSStatus) -> String{
        let cfStr = SecCopyErrorMessageString(status, nil)
        
        if let cfStr = cfStr {
            return String(NSString(string: cfStr))
        }else{
            return "no message"
        }
    }
}

enum KeyChainError: Error{
    case parseError
    case getDataFailure
    case unkown(String)
    case notFound
}
