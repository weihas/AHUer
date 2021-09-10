//
//  LogginView.swift
//  AHUer
//
//  Created by WeIHa'S on 2021/9/9.
//

import SwiftUI

struct LogginView: View {
    @State var studentId: String = ""
    @State var password: String = ""
    @State var isBachelor: Bool = true
    
    var body: some View {
        VStack{
            Picker(selection: $isBachelor, label: Text("Picker")) {
                Text("本科生").tag(true)
                Text("研究生").tag(false)
            }
            .padding(.top, 20)
            .padding(.horizontal, 100)
            .pickerStyle(SegmentedPickerStyle())
            Spacer()
            HStack{
                Text("学号:")
                TextField("学号", text: $studentId)
            }
            .padding()
            Divider().padding(.horizontal)
            HStack{
                Text("密码:")
                SecureField("密码", text: $password)
            }
            .padding()
            Spacer()
            Button(action: {
                print("认证")
            }, label: {
                Label("认证", systemImage: "chevron.forward.square")
            })
            .buttonStyle(ColorButtonStyle(color: .blue))
            
            Spacer()
        }
        .padding()
        .navigationBarTitle("教务认证")
    }
}







struct LogginView_Previews: PreviewProvider {
    static var previews: some View {
        LogginView()
    }
}
