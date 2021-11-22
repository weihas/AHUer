//
//  AhuerAPIProvider.swift
//  AHUer
//
//  Created by WeIHa'S on 2021/10/20.
//

import Foundation
import Moya

/// AHUerAPI容器
struct AhuerAPIProvider{
    /// moya请求提供
    private static let provider = MoyaProvider<AHUerAPI>()
    
    private var requestTimeOut: Double = 30
//    (statusCode: Int, msg: String?),
    
    typealias successCallback = ([String:Any]?) -> Void
    typealias errorCallBack =  (Int) -> Void
    typealias failureCallBack =  (MoyaError) ->Void
    
    
    static func NetRequest(_ target: AHUerAPI, success successCallback: @escaping successCallback, error errorCallBack: @escaping errorCallBack, failure failureCallBack: @escaping failureCallBack){
        print("==> Start " + target.APILogName)
        provider.request(target) { result in
            switch result {
            case .success(let respon):
                do {
                    let filterRespon = try respon.filterSuccessfulStatusCodes()
                    if let analysis = try filterRespon.mapJSON(failsOnEmptyData: true) as? [String:Any]{
                        successCallback(analysis)
                        print(NSHomeDirectory())
//                        print(provider.session)
                        for d in HTTPCookieStorage.shared.cookies ?? [] {
                            print(d.name)
                            print(d.value)
                        }
                        
                    }
                }catch let error{
                    errorCallBack((error as? MoyaError)?.response?.statusCode ?? -1)
                }
            case .failure(let error):
                failureCallBack(error)
            }
        }
    }
}

struct AhuerAPIProviderStatus: Error {
    var status: Int
    var msg: String
}
