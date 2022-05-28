//
//  LogginDetailView.swift
//  AHUer
//
//  Created by WeIHa'S on 2022/5/29.
//

import SwiftUI

struct LogginDetailView: View {
    var body: some View {
        NavigationView {
        Form {
            Section {
                VStack(alignment: .leading) {
                    Text("Q: 什么是登录源?")
                    Text("A: 登录源就是指后端获取数据的源头")
                }
                
                VStack(alignment: .leading) {
                    Text("Q: 换用不同登录源有什么区别?")
                    Text("A: 一般来说没什么区别，但是智慧安大比教务系统慢一点，如果某个登录源挂了可以换用另外一个")
                    
                }
            }
            
            Section {
                VStack(alignment: .leading) {
                    Text("Q: 保存登录状态30天是什么意思?")
                    Text("A: 程序登陆后会获得登录状态cookie，如果不勾选，就不会保存到本地，下次打开app时需要重新登录")
                }
            }
        }
        .navigationTitle("登录 Q&A")
        .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct LogginDetailView_Previews: PreviewProvider {
    static var previews: some View {
        LogginDetailView()
    }
}
