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
    
    
    func getDistribution(courseName: String) async throws {
        let respon = try await AHUerAPIProvider.asyncRequest(.gradeDistribution(courseName: courseName))
        var result = [Distribution]()
        let data = respon["data"].arrayValue
        for datum in data {
            guard let id =  datum["courseId"].string,
                  let name = datum["courseName"].string,
                  let moreThan80 = datum["moreThanEighty"].double,
                  let moreThan60 = datum["moreThanSixty"].double else { continue }
            result.append(Distribution(id: id, name: name, moreThan80: moreThan80, moreThan60: moreThan60))
        }
        
        self.distributions = result
        
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
