//
//  HomePageShow.swift
//  AHUer
//
//  Created by WeIHa'S on 2021/11/12.
//

import Foundation
import Combine

class HomePageShow: ObservableObject {
    @Published private var model: HomePageInfo
    
    init() {
        model = HomePageInfo()
    }
    
    lazy var emptyClassVM = EmptyRoomShow()
    lazy var scoreViewVM = ScoreShow()
    lazy var examSiteVM = ExamSiteShow()
    lazy var distributionVM = DistributionShow()
    lazy var bathInfoVM = BathOpenShow()
    lazy var moreVM = MoreViewShow()
    
    // MARK: - Access to Model
    
    var nextCourse: Course?{
        return model.nextCourse
    }
    
    var NorthBathroomisMen: Bool{
        return model.northBathroomisMen
    }
    
    var buttonsInfo: [HomePageFunc]{
        return HomePageFunc.allCases.filter({$0.tag.contains(.showInHome)})
    }
    
    var gpa: (term: String, global: String) {
        let thisTerm = model.gpa.thisterm == 0 ? "-.--" : "\(model.gpa.thisterm)"
        let global = model.gpa.all == 0 ? "-.--" : "\(model.gpa.all)"
        return (thisTerm, global)
    }
    
    var examInfo: (name: String, day: Int) {
        return ("高等数学",9)
    }
    
    
    var welcomeTitle: String {
        guard let id = model.myId else { return "请登录" }
        return "\(id)👋"
    }
    
    var welcomeSubtitle: String? {
        guard model.myId != nil else { return nil }
        if model.courseCount < 1 {
            return "你今天没有课"
        }
        return "你今天还有\(model.courseCount)节课"
    }
    
    // MARK: -Intent(s)
    
    func freshModel() {
        model.freshUser()
        model.fetchImmediatelyLecture()
        model.fetchMyScore()
    }
    
    deinit {
        print("🌀HomePageShow released")
    }
}
