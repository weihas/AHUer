//
//  DistributionView.swift
//  AHUer
//
//  Created by WeIHa'S on 2021/12/28.
//

import SwiftUI

struct DistributionView: View {
    @ObservedObject var vm: DistributionShow
    @State var courseName: String = ""
    @State var show: Bool = false
    var body: some View {
        VStack{
            searchBar
//            Divider()
            Spacer()
        }
        .navigationTitle("成绩分布")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    
    var searchBar: some View{
        VStack {
            TextField("输入课程名称", text: $courseName){
                vm.getDistribution(courseName: courseName)
            }
                .padding()
            
            .background(Capsule().stroke(Color.meiRed).padding(5))
            .overlay(
                HStack{
                    if show {
                        Spacer()
                        Button {
                            vm.getDistribution(courseName: courseName)
                            withAnimation {
                                show = false
                            }
                        } label: {
                            Image(systemName: "magnifyingglass")
                                .font(.system(size: 20))
                                .padding(.trailing)
                        }
                    }
                }
            )
            Divider()
            LazyVGrid(columns: Array(repeating: GridItem(.adaptive(minimum: 80), spacing: 10, alignment: .leading), count: 3)){
                ForEach(0..<vm.tipsRegularly.count){ index in
                    Button(vm.tipsRegularly[index]) {
                        print(index)
                    }
                    .lineLimit(1)
                    .padding(.horizontal)
                    .padding(.vertical,5)
                    .background(Capsule().fill(Color.skyBlue))
                }
            }
            .padding()
  
        }
        .onTapGesture {
            withAnimation{
                show = true
            }
        }
    }
}

struct DistributionView_Previews: PreviewProvider {
    static var previews: some View {
        DistributionView(vm: DistributionShow())
    }
}
