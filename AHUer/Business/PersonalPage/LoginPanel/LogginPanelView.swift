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
    @Environment(\.editMode) var editmode
    var body: some View {
        VStack{
            Picker(selection: $vm.logginType, label: Text("Picker")) {
                Text("教务系统").tag(false)
                Text("智慧安大").tag(true)
            }
            .padding(.top, 20)
            .padding(.horizontal, 100)
            .pickerStyle(SegmentedPickerStyle())
            logginTextFiled
                .padding(.vertical , 100)
            Spacer()
            Button {
                Task {
                    appInfo.isLoggin = await vm.loggin()
                }
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
    
    
    var logginTextFiled: some View {
        VStack{
            TextField("学号", text: $vm.userID)
                .textContentType(.username)
                .keyboardType(.asciiCapable)
                .padding()
                .background(Capsule().stroke(Color.blue).padding(5))
            SecureField("密码", text: $vm.password)
                .textContentType(.password)
                .padding()
                .background(Capsule().stroke(Color.blue).padding(5))
        }
    }
    
    
    
}

//struct LogginPanelView_Previews: PreviewProvider {
//    static var previews: some View {
//        LogginPanelView()
//    }
//}
