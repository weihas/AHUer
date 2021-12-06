//
//  ExamSiteView.swift
//  AHUer
//
//  Created by WeIHa'S on 2021/9/12.
//

import SwiftUI

struct ExamSiteView: View {
    @ObservedObject var vm: ExamSiteShow
    var body: some View {
        VStack{
            Text("考试查询")
        }
        .navigationTitle("考试查询")
        .navigationBarTitleDisplayMode(.inline)
    }
}







//struct ExamSiteView_Previews: PreviewProvider {
//    static var previews: some View {
//        ExamSiteView()
//    }
//}
