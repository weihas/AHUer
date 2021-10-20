//
//  AhuerAPIProvider.swift
//  AHUer
//
//  Created by WeIHa'S on 2021/10/20.
//

import Foundation
import Moya

/// AHUerAPI容器
class AhuerAPIProvider{
    /// 静止变量，全应用统一
    static let defaults = AhuerAPIProvider()
    
    /// moya请求提供
    private let provider = MoyaProvider<AHUerAPI>()
    
    
    /// 登录
    /// - Parameters:
    ///   - userId: 用户的ID
    ///   - password: 用户密码
    ///   - type: 登录方式
    func loggin(userId: String, password: String, type: String){
        print("==>logging ...")
        guard let pw = password.rsaCrypto() else {return}
        provider.request(.login(userId: userId, password: pw, type: 2)) { result in
            print(result)
            switch result {
            case .success(let respon):
                print(respon)
                if let logginResponse = try? respon.map(LogginResponse.self) {
                    if logginResponse.code == 0{
                        print("==> loggin done")
                    }
                }
            case .failure(let error):
                print(error)
                print("==> loggin error")
            }
        }
        print("Error")
        
        struct LogginResponse: Codable{
            let code: Int?
            let msg: String?
            let data: loginData?
            struct loginData: Codable{
                let name: String?
            }
        }
    }
    
    
    /// 获取课表
    /// - Parameters:
    ///   - schoolYear: 学年
    ///   - schoolTerm: 学期
    func getSchedule(schoolYear: String, schoolTerm: String){
        provider.request(.schedule(schoolYear: schoolYear, schoolTerm: schoolTerm)) { result in
            print(result)
            switch result {
            case .success(let respon):
                if let sched = try? respon.mapJSON(){
                    print(sched)
                }
                if let schedule = try? respon.map(ScheduleResponse.self) {
                    if schedule.code == 0{
                        print("====>get Done")
                    }
                }
                print("error")
            case .failure(let error):
                print(error)
                print("====> Get Schedule error")
            }
        }
        
        struct ScheduleResponse: Codable {
            let code: Int?
            let msg: String?
            let data: [ScheduleData]?
            
            struct ScheduleData: Codable {
                let weekday: String?
                let startWeek: String?
                let endWeek: String?
                let location: String?
                let name: String?
                let teacher: String?
                let length: String?
                let startTime: String?
                let singleDouble: String?
                let courseId: String?
                let extra: String?
            }
        }
    }
    
    
}

