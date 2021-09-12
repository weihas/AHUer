//
//  EmptyClassView.swift
//  AHUer
//
//  Created by WeIHa'S on 2021/9/12.
//

import SwiftUI

struct EmptyClassView: View {
    enum Campus {
        case LongHe, Qinyuan
    }
    
    @State var campus: Campus = Campus.Qinyuan
    @State var topExpanded: Bool = false
    @State var tExpanded: Bool = false
    
    var body: some View {
        VStack{
            DisclosureGroup(campus == .Qinyuan ? "磬苑校区" : "龙河校区", isExpanded: $topExpanded) {
                Picker("校区选择", selection: $campus){
                    Text("磬苑校区").tag(Campus.Qinyuan)
                    Text("龙河校区").tag(Campus.LongHe)
                }.aspectRatio(0.5, contentMode: .fill)
            }
            DisclosureGroup(campus == .Qinyuan ? "Moring" : "AfterNoon", isExpanded: $tExpanded) {
                Picker("校区选择", selection: $campus){
                    Text("磬苑校区").tag(Campus.Qinyuan)
                    Text("龙河校区").tag(Campus.LongHe)
                }.aspectRatio(0.5, contentMode: .fill)
            }
        }
        
    }
}

struct EmptyClassView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyClassView()
    }
}
