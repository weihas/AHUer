//
//  Data+Helper.swift
//  AHUer
//
//  Created by WeIHa'S on 2021/9/9.
//

import Foundation

public extension Date {
    // MARK: 1.1、获取当前 秒级 时间戳 - 10 位
    /// 获取当前 秒级 时间戳 - 10 位
    static var secondStamp : String {
        let timeInterval: TimeInterval = Self().timeIntervalSince1970
        return "\(Int(timeInterval))"
    }
    
    // MARK: 1.2、获取当前 毫秒级 时间戳 - 13 位
    /// 获取当前 毫秒级 时间戳 - 13 位
    static var milliStamp : String {
        let timeInterval: TimeInterval = Self().timeIntervalSince1970
        let millisecond = CLongLong(round(timeInterval*1000))
        return "\(millisecond)"
    }
    
    // MARK: 1.3、获取当前的时间 Date
    /// 获取当前的时间 Date
    static var currentDate : Date {
        return Self()
    }
    
    //以字符串的形式获取时和分
    var hourMinute: String {
        "\(self.hour):\(self.minute)"
    }
    
        
        ///以字符串的形式获取年-月-日
    var yearMonthDay: String {
        "\(self.year)-\(self.month)-\(self.day)"
    }
    // MARK: 1.4、从 Date 获取年份
    /// 从 Date 获取年份
    var year: Int {
        return Calendar.current.component(Calendar.Component.year, from: self)
    }
    
    // MARK: 1.5、从 Date 获取月份
    /// 从 Date 获取年份
    var month: Int {
        return Calendar.current.component(Calendar.Component.month, from: self)
    }
    
    // MARK: 1.6、从 Date 获取 日
    /// 从 Date 获取 日
    var day: Int {
        return Calendar.current.component(.day, from: self)
    }
    
    // MARK: 1.7、从 Date 获取 小时
    /// 从 Date 获取 日
    var hour: Int {
        return Calendar.current.component(.hour, from: self)
    }
    
    // MARK: 1.8、从 Date 获取 分钟
    /// 从 Date 获取 分钟
    var minute: Int {
        return Calendar.current.component(.minute, from: self)
    }
    
    // MARK: 1.9、从 Date 获取 秒
    /// 从 Date 获取 秒
    var second: Int {
        return Calendar.current.component(.second, from: self)
    }
    
    // MARK: 1.9、从 Date 获取 毫秒
    /// 从 Date 获取 毫秒
    var nanosecond: Int {
        return Calendar.current.component(.nanosecond, from: self)
    }
    
    /// 从 Date 获取 周几,周一是0，周日是6
    var weekDay: Int{
        let result = Calendar.current.component(.weekday, from: self)
        return (result - 1 >= 0) ? result - 1 : 7
    }
    
    var weekDayInChinese: String{
        var day: String = ""
        switch Calendar.current.component(.weekday, from: self){
        case 1:
            day = "周日"
        case 2:
            day = "周一"
        case 3:
            day = "周二"
        case 4:
            day = "周三"
        case 5:
            day = "周四"
        case 6:
            day = "周五"
        default:
            day = "周六"
        }
        return day
    }
    
    ///昨天的日期
    var yesterDayDate: Date? {
        return adding(day: -1)
    }
    
    
    // MARK: 3.3、明天的日期
    /// 明天的日期
    var tomorrowDate: Date? {
        return adding(day: 1)
    }
    
    // MARK: 3.4、前天的日期
    /// 前天的日期
    var theDayBeforYesterDayDate: Date? {
        return adding(day: -2)
    }
    
    // MARK: 3.5、后天的日期
    /// 后天的日期
    var theDayAfterYesterDayDate: Date? {
        return adding(day: 2)
    }
    
    /// 判断两个日期是不是同一天
    /// - Parameter anthor: anthor description
    /// - Returns: description
    func isSameDay(with anthor: Date) -> Bool {
        return Calendar.current.isDate(self, inSameDayAs: anthor)
    }
    
    
    // MARK: 3.6、是否为今天（只比较日期，不比较时分秒）
    /// 是否为今天（只比较日期，不比较时分秒）
    /// - Returns: bool
    ///是不是今天
    func isToday() -> Bool {
        return self.isSameDay(with: Date())
    }
    
    
    // MARK: 3.7、是否为昨天
    /// 是否为昨天
    var isYesterday: Bool {
        // 1.先拿到昨天的 date
        guard let date = Date().yesterDayDate else {
            return false
        }
        // 2.比较当前的日期和昨天的日期
        return isSameYeaerMountDay(date)
    }
    
    // MARK: 3.8、是否为前天
    /// 是否为前天
    var isTheDayBeforeYesterday: Bool  {
        // 1.先拿到前天的 date
        guard let date = Date().theDayBeforYesterDayDate else {
            return false
        }
        // 2.比较当前的日期和昨天的日期
        return isSameYeaerMountDay(date)
    }
    
    // MARK: 3.9、是否为今年
    /// 是否为今年
    var isThisYear: Bool  {
        let calendar = Calendar.current
        let nowCmps = calendar.dateComponents([.year], from: Date())
        let selfCmps = calendar.dateComponents([.year], from: self)
        let result = nowCmps.year == selfCmps.year
        return result
    }
    
    // MARK: 3.10、是否为 同一年 同一月 同一天
    /// 是否为  同一年  同一月 同一天
    /// - Returns: bool
    var isSameYearMonthDayWithToday: Bool {
        return isSameYeaerMountDay(Date())
    }
    
    /// 日期的加减操作
    /// - Parameter day: 天数变化
    /// - Returns: date
    func adding(day: Int) -> Date? {
        return Calendar.current.date(byAdding: DateComponents(day:day), to: self)
    }
    
    /// 是否为  同一年  同一月 同一天
    /// - Parameter date: date
    /// - Returns: 返回bool
    private func isSameYeaerMountDay(_ date: Date) -> Bool {
        let com = Calendar.current.dateComponents([.year, .month, .day], from: self)
        let comToday = Calendar.current.dateComponents([.year, .month, .day], from: date)
        return (com.day == comToday.day &&
                    com.month == comToday.month &&
                    com.year == comToday.year )
    }
    
    
}

