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
    case logout(type: Int)
    case emptyRooms(campus: Int, weekday: Int, weekNum: Int, time: Int)
    case grade
}

extension AHUerAPI: TargetType {

    public var baseURL: URL { return URL(string: "https://ahuer.cn")! }
    
    public var path: String {
        switch self {
        case .login:
            return "/api/login"
        case .schedule:
            return "/api/schedule"
        case .logout:
            return "api/logout"
        case .emptyRooms:
            return "/api/emptyRoom"
        case .grade:
            return "/api/grade"
        }
    }

    public var method: Moya.Method {
        switch self {
        case .login:
            return .post
        case .schedule:
            return .get
        case .logout:
            return .get
        case .emptyRooms:
            return .get
        case .grade:
            return .get
        }
    }

    public var task: Task {
        switch self {
        case .login(let userId, let password, let type):
            return .requestParameters(parameters: ["userId": userId, "password": password, "type": type], encoding: URLEncoding.default)
        case .schedule(let schoolYear, let schoolTerm):
            return .requestParameters(parameters: ["schoolYear": schoolYear, "schoolTerm": schoolTerm], encoding: URLEncoding.default)
        case .logout(let type):
            return .requestParameters(parameters: ["type": type], encoding: URLEncoding.default)
        case .emptyRooms(let campus, let weekday, let weekNum, let time):
            return .requestParameters(parameters: ["campus": campus, "weekday": weekday, "weekNum": weekNum, "time": time], encoding: URLEncoding.default)
        case .grade:
            return .requestPlain
        }
    }

    public var headers: [String: String]? {
        return ["Content-Type" : "application/x-www-form-urlencoded; charset=utf-8"]
    }
    
    public var sampleData: Data {
        return "{}".data(using: String.Encoding.utf8)!
    }
}
