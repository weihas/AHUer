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
        
        if let description = Self.messageForCode[code] {
            return description
        }
        
        if let des = des {
//            if code == -1 {
//                let begin = des.index(des.startIndex, offsetBy: 2)
//                let end = des.index(des.endIndex, offsetBy: -3)
//                return String(des[begin...end])
//            }
            return des
        }
        
        return "发生未知错误"
    }
    
    init(code: Int, title: String) {
        self.code = code
        self.des = Self.messageForCode[code]
        self.title = title
    }
    
    init(code: Int, title: String, message: String? = nil) {
        
        self.title = title + "失败"
        self.code = message?.filterCode ?? code
        self.des = message

    }
    
    
    fileprivate static let messageForCode: [Int:String] = [
        -11: "JSON解析失败",
         -9: "尚未登录",
         -8: "登录状态过期, 请重新登录",
         -7: "网络连接失败, 请检查互联网连接",
         0: "OK",
         400: "参数错误",
         404: "接口不存在",
    ]
    
}

fileprivate extension String {
    var filterCode: Int? {
        if self.contains("The Internet connection appears to be offline.") {
            return -7
        }
        
        if self.contains("无效的session，请尝试重新认证。") {
            //如果当前有状态
            if Student.nowUser() != nil {
                //登录过期
                return -8
            }
            //尚未登录
            return -9
        }
        
        return nil
    }
}

