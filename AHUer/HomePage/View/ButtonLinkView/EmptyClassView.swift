//
//  EmptyClassView.swift
//  AHUer
//
//  Created by WeIHa'S on 2021/9/12.
//

import SwiftUI

struct EmptyClassView: View{
    @ObservedObject var vm: EmptyClassShow
    
    @State var topExpanded: Bool = false
    
    var body: some View {
        VStack{
            Picker("校区选择", selection: $vm.campus){
                Text("磬苑校区").tag(Campus.Qinyuan)
                Text("龙河校区").tag(Campus.LongHe)
            }
            .padding(.horizontal)
            .pickerStyle(SegmentedPickerStyle())
            Button("show"){
                topExpanded.toggle()
            }

            List(vm.emptyRooms){ room in
                HStack{
                    Text(room.pos)
                    Text(room.seating)
                }
            }
            Spacer()
        }
        .toolbar{
            Button {
                vm.search()
            } label: {
                Label("Search", systemImage: "magnifyingglass")
            }
        }
        .popover(isPresented: $topExpanded) {
            Picker("时间选择", selection: $vm.time){
                ForEach(LectureTime.allCases){ time in
                    Text(time.description).tag(time)
                }
            }
            .padding(.horizontal)
            .pickerStyle(InlinePickerStyle())
        }
        
        .navigationTitle("空教室查询")
        .navigationBarTitleDisplayMode(.inline)
    }
}
