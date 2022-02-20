//
//  HomePageShow.swift
//  AHUer
//
//  Created by WeIHa'S on 2021/11/12.
//

import Foundation
import Combine

class HomePageShow: ObservableObject{
    @Published private var model: HomePageInfo
    
    init() {
        model = HomePageInfo()
    }
    
    // MARK: -Intent
    
    var nextCourse: Course?{
        return model.nextCourse
    }
    
    var NorthBathroomisMen: Bool{
        return model.northBathroomisMen
    }
    
    var buttonsInfo: [HomePageFunc]{
        return HomePageFunc.allCases.filter({$0.tag.contains(.showInHome)})
    }
    
    var gpa: (Double,Double) {
        return model.gpa
    }
    
    var examInfo: (name: String, day: Int) {
        return ("高等数学",9)
    }
    
    func freshImmediatelyLecture() {
        model.fetchImmediatelyLecture()
    }
    
    lazy var emptyClassVM = EmptyRoomShow()
    lazy var scoreViewVM = ScoreShow()
    lazy var examSiteVM = ExamSiteShow()
    lazy var distributionVM = DistributionShow()
    lazy var bathInfoVM = BathOpenShow()
    lazy var moreVM = MoreViewShow()
    
    deinit {
        print("🌀HomePageShow released")
    }
}
