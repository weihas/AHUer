//
//  Today.swift
//  AHUer
//
//  Created by WeIHa'S on 2021/9/8.
//

import Foundation

class Today: ObservableObject {
    @Published private var model: TodayMessages
    
    init() {
        model = TodayMessages()
    }
    
    var gpa: (Double,Double){
        return model.gpa
    }
    
    var todayLectures: [Lecture]{
        return model.lectures
    }
    
    var southBathroomisMen: Bool{
        return model.southBathroomisMen
    }
}
