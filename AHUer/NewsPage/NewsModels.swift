//
//  NewsModels.swift
//  AHUer
//
//  Created by WeIHa'S on 2021/9/11.
//

import Foundation
import SwiftUI

struct NewsModels {
    var somenews: [NewsItem]
    init() {
        somenews = []
        somenews.append(NewsItem(id: 0, picture: UIImage(named: "imageOfPublisher")!, title: "书记来调研", author: "互联网学院", time: "2月前 9:56"))
        somenews.append(NewsItem(id: 1, picture: UIImage(named: "imageOfPublisher")!, title: "书记来调研", author: "计算机科学与技术学院", time: "1月前 9:56"))
    }
    
}

struct NewsItem: Identifiable {
    var id: Int
    
    var picture: UIImage
    var title: String
    var author: String
    var time: String
}
