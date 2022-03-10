//
//  AddressBookView.swift
//  AHUer
//
//  Created by WeIHa'S on 2021/9/10.
//

import SwiftUI

struct AddressBookView: View {
    @ObservedObject var vm: AddressBookShow
    @State var showPhoneAlert: Bool = false
    @State var willTele: AddressBookData.Tel = .init(id: -1, title: "技术支持", telNum: "123456")
    var body: some View {
        List(vm.model){ source in
            Section(header: Text(source.title)){
                ForEach(source.content){tel in
                    Button(action: {
                        willTele = tel
                        showPhoneAlert = true
                    }, label: {
                        HStack{
                            Text(tel.title)
                            Spacer()
                            Text(tel.telNum)
                        }
                    })
                }
            }
        }
        .listStyle(InsetGroupedListStyle())
        .navigationBarTitle("校园电话", displayMode: .inline)
        .actionSheet(isPresented: $showPhoneAlert) {
            ActionSheet(title: Text("呼叫 " + willTele.title),
                        buttons: [
                            .destructive(
                                Text(willTele.telNum),
                                action: {print("yes")}),
                            .cancel()
                        ]
            )
        }
    }
}



struct addressBookView_Previews: PreviewProvider {
    static var previews: some View {
        AddressBookView(vm: AddressBookShow())
    }
}
