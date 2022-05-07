//
//  MoreViewShow.swift
//  AHUer
//
//  Created by WeIHa'S on 2022/2/20.
//

import SwiftUI

class MoreViewShow: ObservableObject{
    lazy var emptyClassVM = EmptyRoomShow()
    lazy var scoreViewVM = ScoreShow()
    lazy var examSiteVM = ExamSiteShow()
    lazy var distributionVM = DistributionShow()
    lazy var bathInfoVM = BathOpenShow()
    lazy var addressBookVM = AddressBookShow()
    lazy var cardbalanceVM = CardBalanceShow()
    
    init() {
        print("🎈 MoreViewShow init")
    }
    
    var model: [HomePageFunc] = HomePageFunc.allCases.filter({$0.tag.contains(.showInMore)})
    
    var cardInfoForStudy: [HomePageFunc] {
        return model.filter({$0.tag.contains(.study)})
    }
    
    var cardInfoForLife: [HomePageFunc] {
        return model.filter({$0.tag.contains(.life)})
    }
}
