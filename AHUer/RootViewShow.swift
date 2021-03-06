//
//  RootViewShow.swift
//  AHUer
//
//  Created by WeIHa'S on 2021/12/3.
//

import Foundation

class RootViewShow {
    
    init(){}
    
    lazy var HomePageViewModel: HomePageShow = {
        return HomePageShow()
    }()
    
    lazy var timeScheduleViewModel: ScheduleShow = {
        return ScheduleShow()
    }()
    
    lazy var PersonalPageViewModel: PersonalPageShow = {
        return PersonalPageShow()
    }()
}
