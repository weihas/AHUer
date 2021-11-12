//
//  SetStorage.swift
//  AHUer
//
//  Created by WeIHa'S on 2021/11/12.
//

import Foundation

@propertyWrapper
struct SetStorage<T: Codable>{
    //codable协议: 可编码可解码
      var key: String
      var defaultT: T
      private let defaults = UserDefaults.standard
      var wrappedValue: T {
          get{
              guard let jsonString = defaults.string(forKey: key) else { return defaultT }
              guard let jsonData  = jsonString.data(using: .utf8) else { return defaultT }
              guard let value = try? JSONDecoder().decode(T.self, from: jsonData)  else { return defaultT }
              return value
          }
          set{
              guard let jsonData = try? JSONEncoder().encode(newValue) else {return}
              let jsonString = String(bytes: jsonData, encoding: .utf8)
              defaults.setValue(jsonString, forKey: key)
          }
      }
      
      init(key: String, `default`: T) {
          self.key = key
          self.defaultT = `default`
        //`default`上引号的意思是取消系统关键字的意义，变成普通值
      }
  }
