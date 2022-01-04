//
//  DistributionShow.swift
//  AHUer
//
//  Created by WeIHa'S on 2021/12/28.
//

import Foundation
import SwiftUI

class DistributionShow: ObservableObject{
    @Published var distributions: [Distribution] = []
    
    var tipsRegularly: [String] = ["高等数学","马基","英语","大机","物理","Python"]
    
    
    func getDistribution(courseName: String) {
        AhuerAPIProvider.netRequest(.gradeDistribution(courseName: courseName)) { [weak self] respon in
            guard let self = self else {return}
            var result = [Distribution]()
            if let data = respon?["data"] as? [[String:Any]] {
                for datum in data {
                    guard let id = datum["courseId"] as? String,
                          let name = datum["courseName"] as? String,
                          let moreThan80 = datum["moreThanEighty"] as? Double,
                          let moreThan60 = datum["moreThanSixty"] as? Double else { continue }
                    result.append(Distribution(id: id, name: name, moreThan80: moreThan80, moreThan60: moreThan60))
                }
            }
            self.distributions = result
        } error: { statusCode, message in
            
        } failure: { failure in
            
        }
    }
}

struct Distribution: Identifiable{
    var id: String
    
    var name: String
    var moreThan80: Double
    var moreThan60: Double
    var between60and80: Double{
        return moreThan60-moreThan80
    }
}
