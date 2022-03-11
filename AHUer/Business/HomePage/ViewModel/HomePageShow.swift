//
//  HomePageShow.swift
//  AHUer
//
//  Created by WeIHa'S on 2021/11/12.
//

import Foundation
import SwiftUI

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
    
    var NorthBathroomisMen: Bool{
        return model.northBathroomisMen
    }
    
    //显示在主页面的Button
    var homeButtons: [HomePageFunc]{
        return HomePageFunc.allCases.filter({$0.tag.contains(.showInHome)})
    }
    
    var gpa: (term: String, global: String) {
        let thisTerm = model.gpa.thisterm == 0 ? "-.--" : "\(model.gpa.thisterm)"
        let global = model.gpa.all == 0 ? "-.--" : "\(model.gpa.all)"
        return (thisTerm, global)
    }
    
    var examInfo: (title: String, subtitle: String) {
        if let exam = model.exam {
            return (title: "距离\(exam.name)考试", subtitle: "还有\(exam.time)天")
        } else {
            return (title: "暂无考试", subtitle: "")
        }
    }
    
    // MARK: -Intent(s)
    
    func freshModel() {
        model.fetchMyScore()
    }
    
    deinit {
        print("🌀HomePageShow released")
    }
}
