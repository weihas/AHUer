//
//  String+Extension.swift
//  AHUer
//
//  Created by WeIHa'S on 2022/5/6.
//

import Foundation

extension String {
    func transformToPinYin() -> String {
        
        let mutableString = NSMutableString(string: self)
        //把汉字转为拼音
        CFStringTransform(mutableString, nil, kCFStringTransformToLatin, false)
        //去掉拼音的音标
        CFStringTransform(mutableString, nil, kCFStringTransformStripDiacritics, false)

        let string = String(mutableString)
        //去掉空格
        return string.replacingOccurrences(of: " ", with: "")
    }
    
    var isRegularForUserName: Bool{
        let regex = "^[A-Z][0-9]{0,8}$"
        guard let RE = try? NSRegularExpression(pattern: regex, options: .caseInsensitive) else { return false }
        let match =  RE.matches(in: self, options: .reportCompletion, range: NSRange(location: 0, length: self.count))
        return match.count == 0 ? false : true
    }
}
