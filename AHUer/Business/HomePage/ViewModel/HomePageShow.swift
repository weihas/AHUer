//
//  HomePageShow.swift
//  AHUer
//
//  Created by WeIHa'S on 2021/11/12.
//

import Foundation
import SwiftUI

class HomePageShow: ObservableObject {
    @Published private var nextCourseModel: HomePageNextLecture
    @Published private var tipsModel: HomePageTips
    
    
    init() {
        tipsModel = HomePageTips()
        nextCourseModel = HomePageNextLecture()
    }
    
    lazy var emptyClassVM = EmptyRoomShow()
    lazy var scoreViewVM = ScoreShow()
    lazy var examSiteVM = ExamSiteShow()
    lazy var distributionVM = DistributionShow()
    lazy var bathInfoVM = BathOpenShow()
    lazy var moreVM = MoreViewShow()
    
    // MARK: - Access to Model
    
    var welcomeTitle: String {
        guard let id = nextCourseModel.myId else { return "请登录" }
        return "\(id)👋"
    }
    
    var welcomeSubtitle: String? {
        guard nextCourseModel.myId != nil else { return nil }
        if nextCourseModel.courseCount < 1 {
            return "你今天没有课"
        }
        return "你今天还有\(nextCourseModel.courseCount)节课"
    }
    
    var northBathisMen: Bool{
        return tipsModel.southisMen
    }
    
    
    var nextCourseName: String {
        return nextCourseModel.nextCourse?.name ?? "暂无课程"
    }
    
    var nextCourseProgress: (Double, String) {
        return nextCourseModel.progress
    }
    
    var nextCourseStartTime: String {
        return StartTime(rawValue: Int(nextCourseModel.nextCourse?.startTime ?? 0))?.des ?? " Time "
    }
    
    var nextCourseTeacher: String {
        return nextCourseModel.nextCourse?.teacher ?? "Teacher"
    }
    
    var nextCourseLocation: String {
        return nextCourseModel.nextCourse?.location  ?? "Teacher"
    }
    
    
    
    
    //显示在主页面的Button
    var homeButtons: [HomePageFunc]{
        return HomePageFunc.allCases.filter({$0.tag.contains(.showInHome)})
    }
    
    var gpa: (term: String, global: String) {
        let thisTerm = tipsModel.gpa.thisterm == 0 ? "-.--" : "\(tipsModel.gpa.thisterm)"
        let global = tipsModel.gpa.all == 0 ? "-.--" : "\(tipsModel.gpa.all)"
        return (thisTerm, global)
    }
    
    var examInfo: (title: String, subtitle: String) {
        if let exam = tipsModel.exam, let name = exam.course, let time = exam.time {
            return (title: "距离\(name)考试", subtitle: "还有\(time)天")
        } else {
            return (title: "暂无考试", subtitle: "")
        }
    }
    
    // MARK: -Intent(s)
    
    @MainActor
    func freshModels() {
        nextCourseModel.fecthModel()
        tipsModel.fetchModel()
    }
    
    deinit {
        print("🌀HomePageShow released")
    }
}
