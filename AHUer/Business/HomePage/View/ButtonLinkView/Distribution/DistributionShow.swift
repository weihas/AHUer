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
    @Published var courseName: String = ""
    
    var tipsRegularly: [String] = ["高等数学","马基","英语","大机","物理","Python", "Java"]
    
    var showSearch: Bool {
        !courseName.isEmpty
    }
    
    func getDistribution() {
        guard !courseName.isEmpty else { return }
        Task{
            do {
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
                
                await MainActor.run { [result, weak self] in
                    guard let self = self else { return }
                    self.distributions = result
                }
                
            } catch {
                await AlertView.showAlert(with: error)
            }
        }
    }
    
    @MainActor
    func clearModel() {
        distributions.removeAll()
    }
    
    
    
    deinit {
        print("🌀DistributionShow released")
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
    
    var showForPie: [Double] {
        let high = moreThan80
        let mid = moreThan60-moreThan80
        let low = 1-moreThan60
        
        return [high, mid, low]
    }
    
    var title: String {
        return id + name
    }
    
    var legend: String {
        return "及格率" + String(format:"%.2f", moreThan60 * 100.0) + "%"
    }
    
}
