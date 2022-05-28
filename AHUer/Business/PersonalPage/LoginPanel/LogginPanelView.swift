//
//  LogginPanelView.swift
//  AHUer
//
//  Created by WeIHa'S on 2022/1/27.
//

import SwiftUI

struct LogginPanelView: View {
    
    enum Field: Hashable {
        case usernameField
        case passwordField
    }
    
    @EnvironmentObject var appInfo: AHUAppInfo
    @StateObject var vm: LogginPanelShow
    @FocusState var focusedField: Field?
    @Environment(\.presentationMode) var present
    @Environment(\.editMode) var editmode
    @State var showDetail: Bool = false
    
    var body: some View {
        VStack {
            titleView
            Form {
                logginOriginChoose
                logginTextFiled
                logginButton
            }
        }
        .sheet(isPresented: $showDetail) {
            LogginDetailView()
        }
    }
    
    var titleView: some View {
        VStack {
            Image(systemName: "person.text.rectangle")
                .font(.largeTitle)
                .padding()
            Text("Welcome to AHUer !")
                .font(.custom("Papyrus", size: 20))
        }
    }
    
    var logginOriginChoose: some View {
        Section {
            Picker(selection: $vm.logginOrigin, label: Text("登录选择")) {
                Text("教务系统").tag(false)
                Text("智慧安大").tag(true)
            }
            .pickerStyle(.segmented)
        } header: {
            Text("登录源")
        }
    }
    
    var logginTextFiled: some View {
        Section {
            HStack{
                TextField("StudentID", text: $vm.username)
                    .textContentType(.username)
                    .keyboardType(.asciiCapable)
                    .focused($focusedField, equals: .usernameField)
                Image(systemName: vm.userNameIcon)
            }
            HStack {
                SecureField("Password", text: $vm.password)
                    .textContentType(.password)
                    .focused($focusedField, equals: .passwordField)
                Image(systemName: vm.passwordIcon)
            }
        }
        .foregroundColor(.primary)
    }
    
    var logginButton: some View {
        Section {
            Button {
                if vm.username.isEmpty {
                    focusedField = .usernameField
                } else if vm.password.isEmpty {
                    focusedField = .passwordField
                } else {
                    Task {
                        let result = await vm.loggin()
                        appInfo.isLoggin = result
                    }
                    present.wrappedValue.dismiss()
                }
                
            } label: {
                NavigationLink {
                    EmptyView()
                } label: {
                    Label("登录", systemImage: "paperplane")
                        .foregroundColor(.blue)
                }
            }
        } footer: {
            HStack {
                Button {
                    vm.saveCookie.toggle()
                } label: {
                    Label("保存登录状态30天", systemImage: vm.saveCookie ? "checkmark.circle.fill" : "checkmark.circle")
                }
                Spacer()
                Button {
                    showDetail.toggle()
                } label: {
                    Image(systemName: "info.circle")
                }
            }
        }
    }
}

//struct LogginPanelView_Previews: PreviewProvider {
//    static var previews: some View {
//        LogginPanelView()
//    }
//}
