//
//  LogginPanelView.swift
//  AHUer
//
//  Created by WeIHa'S on 2022/1/27.
//

import SwiftUI

struct LogginPanelView: View {
    @EnvironmentObject var appInfo: AHUAppInfo
    @StateObject var vm: LogginPanelShow
    @Environment(\.presentationMode) var present
    var body: some View {
        VStack{
            Picker(selection: $vm.isBachelor, label: Text("Picker")) {
                Text("本科生").tag(true)
                Text("研究生").tag(false)
            }
            .padding(.top, 20)
            .padding(.horizontal, 100)
            .pickerStyle(SegmentedPickerStyle())
            Spacer()
            HStack{
                Text("学号:")
                TextField("学号", text: $vm.userID)
                    .textContentType(.username)
                    .keyboardType(.asciiCapable)
                
            }
            .padding()
            Divider().padding(.horizontal)
            HStack{
                Text("密码:")
                SecureField("密码", text: $vm.password)
                    .textContentType(.password)
            }
            .padding()
            Spacer()
            Button {
                vm.loggin()
                present.wrappedValue.dismiss()
            } label: {
                Label("认证", systemImage: "chevron.forward.square")
            }
            .buttonStyle(ColorButtonStyle(color: .blue))
            Spacer()
        }
        .padding()
        .navigationBarTitle("教务认证")
    }
}

//struct LogginPanelView_Previews: PreviewProvider {
//    static var previews: some View {
//        LogginPanelView()
//    }
//}
