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
    typealias errorCallBack =  (Int) -> Void
    typealias failureCallBack =  (MoyaError) ->Void
    
    
    static func netRequest(_ target: AHUerAPI, success successCallback: @escaping successCallback, error errorCallBack: @escaping errorCallBack, failure failureCallBack: @escaping failureCallBack){
        provider.request(target) { result in
            switch result {
            case .success(let respon):
                if let analysis = try? respon.mapJSON(failsOnEmptyData: true) as? [String:Any]{
                    do {
                        let _ = try respon.filterSuccessfulStatusCodes()
                        successCallback(analysis)
                    }catch{
                        errorCallBack(analysis["code"] as? Int ?? -1)
                    }
                }else{
                    errorCallBack(-10)
                }
            case .failure(let error):
                failureCallBack(error)
            }
        }
    }
}
