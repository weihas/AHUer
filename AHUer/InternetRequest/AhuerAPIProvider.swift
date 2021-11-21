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
    /// 单例，全应用统一
    static let defaults = AhuerAPIProvider()
    
    /// moya请求提供
    private let provider = MoyaProvider<AHUerAPI>()
    
    
    /// 登录
    /// - Parameters:
    ///   - userId: 用户的ID
    ///   - password: 用户密码
    ///   - type: 登录方式
    ///   - complete: 登录请求结束回调
    func loggin(userId: String, password: String, type: Int = 1 , completion: @escaping ((Int, String?), String, String?) -> Void) {
        print("==>logging ...")
        DispatchQueue.global().async { [weak self] in
            guard let pw = password.rsaCrypto() else {return}
            self?.provider.request(.login(userId: userId, password: pw, type: type)) { result in
                print(result)
                switch result {
                case .success(let respon):
                    print("==>loggin request done")
                    if let logginAnalysis = try? respon.mapJSON() as? [String:Any?]{
                        if let responStatus = logginAnalysis["code"] as? Int{
                            let msg = logginAnalysis["msg"] as? String
                            if let data = logginAnalysis["data"] as? [String:Any?]{
                                let userName = data["name"] as? String
                                if responStatus == 0{
                                    UserDefaults.standard.setValue(pw, forKey: "AHUPassword")
                                }
                                completion((responStatus,msg),userId,userName)
                            }
                        }
                    }else{
                        print("==>analysis fail")
                    }
                case .failure(let error):
                    print(error)
                    print("==>request error")
                }
            }
        }
    }
    
    
    
    /// 登出
    /// - Parameters:
    ///   - type: 登录种类，默认为2
    ///   - completion: 登出请求完成回调
    func logout(type: Int = 2, completion: @escaping ((Int, String?)) -> Void){
        print("==>logouting ...")
        DispatchQueue.global().async { [weak self] in
            self?.provider.request(.logout(type: type)) { result in
                print(result)
                switch result{
                case .success(let respon):
                    print("==>logout request done")
                    if let logoutAnalysis = try? respon.mapJSON() as? [String:Any] {
                        if let responStatus = logoutAnalysis["code"] as? Int{
                            let msg = logoutAnalysis["msg"] as? String
                            completion((responStatus,msg))
                        }
                    }else{
                        print("==>analysis fail")
                    }
                case .failure(let error):
                    print(error)
                    print("==>request error")
                }
            }
        }
    }
    
    
    /// 获取课表
    /// - Parameters:
    ///   - schoolYear: 学年
    ///   - schoolTerm: 学期
    ///   - complete: 课表请求结束回调
    func getSchedule(schoolYear: String, schoolTerm: String, completion: @escaping ((Int, String?), [[String:Any]]?) -> Void) {
        print("==>gettingSchedule ...")
        DispatchQueue.global().async { [weak self] in
            self?.provider.request(.schedule(schoolYear: schoolYear, schoolTerm: schoolTerm)) { result in
                print(result)
                switch result {
                case .success(let respon):
                    print("==>get schedule request done")
                    if let schedule = try? respon.mapJSON(failsOnEmptyData: true) as? [String: Any]{
                        if let responStatus = schedule["code"] as? Int{
                            let msg = schedule["msg"] as? String
                            guard let data = schedule["data"] as? [[String:Any]] else { return }
                            completion((responStatus, msg), data)
                        }
                    }else{
                        print("==>analysis fail")
                    }
                case .failure(let error):
                    print(error)
                    print("==>request error")
                }
            }
        }
    }
    
    
    /// 获取空教室
    /// - Parameters:
    ///   - campus: 校区
    ///   - weekNum: 第几周
    ///   - weekday: 星期几
    ///   - time: 时间
    ///   - completion: 空教室获取回调
    func getEmptyRoom(campus: Campus, weekNum: Int, weekday: Int, time: LectureTime, completion: @escaping ((Int,String?),[[String:Any]]?) -> Void){
        print("==>getEmptyRoom ...")
        DispatchQueue.global().async { [weak self] in
            self?.provider.request(.emptyRooms(campus: campus.hashValue, weekday: weekday, weekNum: weekNum, time: time.id)) { result in
                print(result)
                switch result {
                case .success(let respon):
                    print("==>get EmptyRoom request done")
                    if let emptyRoomAnalysis = try? respon.mapJSON(failsOnEmptyData: true) as? [String: Any]{
                        if let responStatus = emptyRoomAnalysis["code"] as? Int{
                            let msg = emptyRoomAnalysis["msg"] as? String
                            let data = emptyRoomAnalysis["data"] as? [[String:Any]]
                            completion((responStatus, msg), data)
                        }
                    }else{
                        print("==>analysis fail")
                    }
                case .failure(let error):
                    print(error)
                    print("==>request error")
                }
            }
        }
    }
    
    deinit{
        print("🌀AhuAPIProvider released")
    }
    
    
}

struct AhuerAPIProviderStatus: Error {
    var status: Int
    var msg: String
}
