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
    case schedule(schoolYear: String, schoolTerm: Int)
    case logout(type: Int)
    case emptyRooms(campus: Int, weekday: Int, weekNum: Int, time: Int)
    case grade
    case examInfo(schoolYear: String, schoolTerm: Int)
    case gradeDistribution(courseName: String)
    case bathroom
    case campusCardBalance
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
        case .examInfo:
            return "/api/examInfo"
        case .gradeDistribution:
            return "/api/grade/distribution"
        case .bathroom:
            return "/api/bathroom/north"
        case .campusCardBalance:
            return "/api/campusCardBalance"
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
        case .examInfo:
            return .get
        case .gradeDistribution:
            return .post
        case .bathroom:
            return .get
        case .campusCardBalance:
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
        case .examInfo(let schoolYear, let schoolTerm):
            return .requestParameters(parameters: ["schoolYear": schoolYear, "schoolTerm": schoolTerm], encoding: URLEncoding.default)
        case .gradeDistribution(let courseName):
            return .requestParameters(parameters: ["courseName": courseName], encoding: URLEncoding.default)
        case .bathroom:
            return .requestPlain
        case .campusCardBalance:
            return .requestPlain
        }
    }

    public var headers: [String: String]? {
        return ["Content-Type" : "application/x-www-form-urlencoded; charset=utf-8"]
    }
    
    public var sampleData: Data {
        return "{}".data(using: String.Encoding.utf8)!
    }
    
    public var APILogName: String{
        
        switch self {
        case .login:
            return "loggin"
        case .schedule:
            return "get schedule"
        case .logout:
            return "logout"
        case .emptyRooms:
            return "get emptyRooms"
        case .grade:
            return "get grade"
        case .examInfo:
            return "get examInfo"
        case .gradeDistribution:
            return "get gradeDistribution"
        case .bathroom:
            return "get bathroom"
        case .campusCardBalance:
            return "get campusCardBalance"
        }
    }
    
    
    public var errorHandelTitle: String{
        switch self {
        case .login:
            return "登录"
        case .schedule:
            return "查询课表"
        case .logout:
            return "登出"
        case .emptyRooms:
            return "空教室查询"
        case .grade:
            return "成绩查询"
        case .examInfo:
            return "考场查询"
        case .gradeDistribution:
            return "成绩分布查询"
        case .bathroom:
            return "浴室查询"
        case .campusCardBalance:
            return "余额获取"
        }
    }
}

final class AHUerAlertPlugin: PluginType {
    var startTime: CFAbsoluteTime?
    
    func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
        var myRequest = request
        myRequest.timeoutInterval = 20
        return myRequest
    }
    
    func willSend(_ request: RequestType, target: TargetType) {
        if let ahuTarget = target as? AHUerAPI {
            startTime = CFAbsoluteTimeGetCurrent()
            print("====>🌐 Start " + ahuTarget.APILogName)
        }
    }
    
    func didReceive(_ result: Result<Response, MoyaError>, target: TargetType) {
        if let ahuTarget = target as? AHUerAPI, let startTime = self.startTime {
            print("====>🌐 Receive " + ahuTarget.APILogName + " back " + "耗时 " + "\(CFAbsoluteTimeGetCurrent() - startTime) s\n")
        }
    }
}


extension HTTPCookieStorage{
    static func saveAHUerCookie(){
        guard let cookies = shared.cookies(for: URL(string: "https://ahuer.cn/api")!) else { return }
        for cookie in cookies{
            guard var props = cookie.properties else { continue }
            props[.expires] = Date().adding(day:30)
            props[.discard] = nil
            guard let newCookie = HTTPCookie(properties: props) else { continue }
            shared.setCookie(newCookie)
        }
    }
    
    static func deleteAHUerCookie(){
        guard let cookies = shared.cookies(for: URL(string: "https://ahuer.cn/api")!) else { return }
        for cookie in cookies{
            shared.deleteCookie(cookie)
        }
    }
}
