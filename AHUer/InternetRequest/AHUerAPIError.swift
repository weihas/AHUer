//
//  AHUerAPIError.swift
//  AHUer
//
//  Created by WeIHa'S on 2022/1/12.
//

import Foundation

struct AHUerAPIError: Error{
    let code: Int
    private let des: String?
    
    /// 错误的标题
    var title: String
    
    /// 错误的描述
    var description: String {
        guard let description = Self.messageForCode[code] else {
            guard let des = des else { return "发生未知错误"}
            return des
        }
        return description
    }
    
    init(code: Int, title: String) {
        self.code = code
        self.des = Self.messageForCode[code]
        self.title = title
    }
    
    init(code: Int, title: String, message: String? = nil) {
        self.code = code
        self.des = message
        self.title = title
    }
    
    
    fileprivate static let messageForCode: [Int:String] = [
        -10: "JSON解析失败",
         -9: "尚未登录",
         6: "网络连接失败，请检查互联网连接",
         0: "OK",
         400: "参数错误",
         404: "接口不存在",
    ]
    
}
