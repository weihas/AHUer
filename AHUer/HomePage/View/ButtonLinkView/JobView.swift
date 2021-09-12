//
//  JobView.swift
//  AHUer
//
//  Created by WeIHa'S on 2021/9/9.
//

import SwiftUI

struct JobView: View {
    @State var showPage: Int = 0
    var body: some View {
        VStack{
            cusPicker(showPage: $showPage)
                .padding()
            Spacer()
        }
        .navigationBarTitle("校招信息", displayMode: .inline)
    }
}

struct cusPicker: View{
    @Binding var showPage: Int
    var body: some View{
        Picker(selection: $showPage, label: Text("Picker")) {
            Text("今天").tag(0)
            Text("明天").tag(1)
            Text("后天").tag(2)
            Text("更多").tag(3)
        }
        .pickerStyle(SegmentedPickerStyle())
    }
}

struct JobView_Previews: PreviewProvider {
    static var previews: some View {
        JobView()
    }
}
