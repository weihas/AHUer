//
//  NewsPlaying.swift
//  AHUer
//
//  Created by WeIHa'S on 2021/9/11.
//

import Foundation

class NewsPlaying: ObservableObject {
    @Published var model: NewsModels
    
    init() {
        model = NewsModels()
    }
    
    var news: [NewsItem] {
        return model.somenews
    }
}
