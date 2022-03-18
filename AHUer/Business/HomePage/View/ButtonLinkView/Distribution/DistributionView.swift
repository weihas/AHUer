//
//  DistributionView.swift
//  AHUer
//
//  Created by WeIHa'S on 2021/12/28.
//

import SwiftUI

struct DistributionView: View {
    @ObservedObject var vm: DistributionShow
    @EnvironmentObject var appInfo: AHUAppInfo
    @State var courseName: String = ""
    @State var show: Bool = false
    var body: some View {
        VStack{
            searchBar
            List(vm.distributions){ distribution in
                DistributionCard(content: distribution)
            }
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
            
            .background(Capsule().stroke(Color.meiRed).padding(10))
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
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))]){
                ForEach(0..<vm.tipsRegularly.count, id: \.self){ index in
                    let name = vm.tipsRegularly[index]
                    Button(name) {
                        vm.getDistribution(courseName: name)
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

#warning("完成成绩分布的新List Cell UI制作")
fileprivate struct DistributionCard: View{
    let content: Distribution
    var body: some View {
        VStack(alignment: .leading){
            HStack{
                Text(content.id)
                Text(content.name)
            }
            .font(.headline)
            Text("优秀\(content.moreThan80*100, specifier: "%.2f")%")
            Text("中等\(content.between60and80*100, specifier: "%.2f")%")
            Text("及格率\(content.moreThan60*100, specifier: "%.2f")%")
                .underline()
        }
    }
}

struct DistributionView_Previews: PreviewProvider {
    static var previews: some View {
        var vm = DistributionShow()
        vm.distributions = [Distribution(id: "CG12345", name: "高等数学", moreThan80: 0.45, moreThan60: 0.90),
                            Distribution(id: "CG12345", name: "这是一个测试", moreThan80: 0.45, moreThan60: 0.90)]
        return DistributionView(vm: vm)
    }
}
