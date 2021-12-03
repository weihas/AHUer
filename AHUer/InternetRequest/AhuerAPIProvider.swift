//
//  AhuerAPIProvider.swift
//  AHUer
//
//  Created by WeIHa'S on 2021/10/20.
//

import Foundation
import Moya
import CoreData

/// AHUerAPI容器
struct AhuerAPIProvider{
    private static let provider = MoyaProvider<AHUerAPI>(plugins: [AHUerAlertPlugin()])
    typealias successCallback = ([String:Any]?) -> Void
    typealias errorCallBack =  (_ statusCode: Int, _ message: String) -> Void
    typealias failureCallBack =  (MoyaError) ->Void
    
    
    static func netRequest(_ target: AHUerAPI,
                           success successCallback: @escaping successCallback,
                           error errorCallBack: @escaping errorCallBack,
                           failure failureCallBack: @escaping failureCallBack)
    {
        provider.request(target) { result in
            switch result {
            case .success(let respon):
                if let analysis = try? respon.mapJSON(failsOnEmptyData: true) as? [String:Any]{
                    let msg = analysis["msg"] as? String ?? ""
                    if let status = analysis["success"] as? Bool, status == true {
                        successCallback(analysis)
                    }else{
                        errorCallBack(analysis["code"] as? Int ?? -1, msg)
                    }
                }else{
                    errorCallBack(-10, "JSON解析失败")
                }
            case .failure(let error):
                failureCallBack(error)
            }
        }
    }
}
