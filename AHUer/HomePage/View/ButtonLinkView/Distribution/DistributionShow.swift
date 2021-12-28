//
//  DistributionShow.swift
//  AHUer
//
//  Created by WeIHa'S on 2021/12/28.
//

import Foundation
import SwiftUI

class DistributionShow: ObservableObject{
    
    
    
    
    var tipsRegularly: [String] = ["高等数学","马基","英一","大机","物理","Python"]
    
    
    func getDistribution(courseName: String) {
        AhuerAPIProvider.netRequest(.gradeDistribution(courseName: courseName)) { respon in
        } error: { statusCode, message in
            
        } failure: { failure in
            
        }
    }
}
