//
//  CoursesGet.swift
//  AHUer
//
//  Created by WeIHa'S on 2021/10/17.
//


import Foundation
import Moya

public enum AHUerAPI {
    case login(userId: String, password: String, type: Int)
    case schedule(schoolYear: String, schoolTerm: String)
}

extension AHUerAPI: TargetType {

    public var baseURL: URL { return URL(string: "https://ahuer.cn")! }
    
    public var path: String {
        switch self {
        case .login:
            return "/api/login"
        case .schedule:
            return "/api/schedule"
        }
    }

    public var method: Moya.Method {
        switch self {
        case .login:
            return .post
        case .schedule:
            return .get
        }
    }

    public var task: Task {
        switch self {
        case .login(let userId, let password, let type):
            return .requestParameters(parameters: ["userId": userId, "password": password, "type": type], encoding: URLEncoding.default)
        case .schedule(let schoolYear, let schoolTerm):
            return .requestParameters(parameters: ["schoolYear": schoolYear, "schoolTerm": schoolTerm], encoding: URLEncoding.default)
        }
    }

    public var headers: [String: String]? {
        return ["Content-Type" : "application/x-www-form-urlencoded; charset=utf-8"]
    }
    
    public var sampleData: Data {
        return "{}".data(using: String.Encoding.utf8)!
    }
}
