//
//  AddressBookView.swift
//  AHUer
//
//  Created by WeIHa'S on 2021/9/10.
//

import SwiftUI

struct AddressBookView: View {
    @ObservedObject var vm: AddressBookLogic
    @State var showPhoneAlert: Bool = false
    @State var willTele: AddressBookData.Tel = .init(id: -1, title: "技术支持", telNum: "123456")
    var body: some View {
        NavigationView{
                List{
                    ForEach(vm.model){source in
                        Section(header: Text(source.title)){
                            ForEach(source.content){tel in
                                Button(action: {
                                    print(tel.telNum)
                                    willTele = tel
                                    showPhoneAlert = true
                                }, label: {
                                    HStack{
                                        Text(tel.title)
                                        Spacer()
                                        Text(tel.telNum)
                                    }
                                })
                                //                            .alert(isPresented: $showPhoneAlert, content: {
                                //                                Alert(title: Text(tel.telNum), primaryButton: .default(Text("呼叫")), secondaryButton: .cancel(Text("取消")))
                                //                            })
                            }
                        }
                    }
                }
                .listStyle(InsetGroupedListStyle())
                .navigationBarTitle("校园电话", displayMode: .inline)
        }
        .actionSheet(isPresented: $showPhoneAlert) {
            ActionSheet(title: Text("呼叫 " + willTele.title), buttons: [.destructive(Text(willTele.telNum), action: {print("yes")}),.cancel()])
        }
    }
}



struct addressBookView_Previews: PreviewProvider {
    static var previews: some View {
        AddressBookView(vm: AddressBookLogic())
    }
}
