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
    func loggin(userId: String, password: String, type: Int = 1 , completion: @escaping (String, String?) -> Void) {
        print("==>logging ...")
        DispatchQueue.global().async { [weak self] in
            guard let pw = password.rsaCrypto() else {return}
            self?.provider.request(.login(userId: userId, password: pw, type: type)) { result in
                print(result)
                switch result {
                case .success(let respon):
                    if let logginResponse = try? respon.mapJSON() as? Dictionary<String, Any?> {
                        if let logginStatus = logginResponse["code"] as? Int, logginStatus == 0{
                            print("==>loggin done")
                            if let data = logginResponse["data"] as? [String:Any?], let userName = data["name"] as? String{
                                UserDefaults.standard.setValue(pw, forKey: "AHUPassword")
                                completion(userId,userName)
                            }
                        }else{
                            print("==>loggin Error")
                        }
                    }
                case .failure(let error):
                    print(error)
                    print("==>loggin error")
                }
            }
        }
    }
    
    
    
    /// 登出
    /// - Parameters:
    ///   - type: 登录种类，默认为2
    ///   - completion: 登出请求完成回调
    func logout(type: Int = 2, completion: @escaping (Bool) -> Void){
        print("==>logouting ...")
        DispatchQueue.global().async { [weak self] in
            self?.provider.request(.logout(type: type)) { result in
                print(result)
                switch result{
                case .success(let respon):
                    print(respon)
                    if let logginResponse = try? respon.mapJSON() as? Dictionary<String, Any> {
                        if let logginStatus = logginResponse["code"] as? Int{
                            print("==>logout done")
                            completion(logginStatus == 0)
                        }
                    }
                case .failure(let error):
                    print(error)
                    print("==> logout error")
                }
            }
        }
    }
    
    
    /// 获取课表
    /// - Parameters:
    ///   - schoolYear: 学年
    ///   - schoolTerm: 学期
    ///   - complete: 课表请求结束回调
    func getSchedule(schoolYear: String, schoolTerm: String, completion: @escaping ([[String:Any]]?) -> Void) {
        print("==>gettingSchedule ...")
        DispatchQueue.global().async { [weak self] in
            self?.provider.request(.schedule(schoolYear: schoolYear, schoolTerm: schoolTerm)) { result in
                print(result)
                switch result {
                case .success(let respon):
                    if let schedule = try? respon.mapJSON(failsOnEmptyData: true) as? Dictionary<String, Any>{
                        if schedule["code"] as! Int == 0{
                            print("==>get schedule Done")
                            guard let data = schedule["data"] as? [[String:Any]]else { return }
                            completion(data)
                        }
                    }else{
                        print("==>get schedule error")
                    }
                case .failure(let error):
                    print(error)
                    print("====> Get Schedule error")
                }
            }
        }
    }
    
    deinit{
        print("🌀AhuAPIProvider released")
    }
    
    
}
