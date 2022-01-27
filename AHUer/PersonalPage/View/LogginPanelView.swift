//
//  LogginPanelView.swift
//  AHUer
//
//  Created by WeIHa'S on 2022/1/27.
//

import SwiftUI

struct LogginPanelView: View {
    @EnvironmentObject var appInfo: AHUAppInfo
    @ObservedObject var vm: PersonalPageShow
    @State var isBachelor: Bool = false
    @State var userID: String = "E01814133"
    @State var password: String = "Whw,0917"
    @State var logginType: Int = 1
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
                TextField("学号", text: $userID)
                    .keyboardType(.asciiCapable)
                
            }
            .padding()
            Divider().padding(.horizontal)
            HStack{
                Text("密码:")
                SecureField("密码", text: $password)
            }
            .padding()
            Spacer()
            Button {
                Task{
                    do {
                        appInfo.isLoggin = try await vm.loggin(userID: userID, password: password, type: logginType)
                    } catch {
                        appInfo.isLoggin = false
                        appInfo.showAlert(with: error)
                    }
                }
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
