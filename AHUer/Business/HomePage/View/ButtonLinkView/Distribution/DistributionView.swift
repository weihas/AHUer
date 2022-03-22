//
//  DistributionView.swift
//  AHUer
//
//  Created by WeIHa'S on 2021/12/28.
//

import SwiftUI
import SwiftUICharts

struct DistributionView: View {
    @ObservedObject var vm: DistributionShow
    @EnvironmentObject var appInfo: AHUAppInfo
    @State var courseName: String = ""
    @State var show: Bool = false
    var body: some View {
        ScrollView {
            searchBar
            bodyCards
            Spacer()
        }
        .navigationTitle("成绩分布")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    var bodyCards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 160), spacing: 10)]) {
            ForEach(vm.distributions) { distribution in
                DistributionCard2(content: distribution)
            }
        }
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

fileprivate struct DistributionCard2: View{
    let content: Distribution
    var body: some View {
        PieChartView(data: content.showForPie, title: content.title, legend: content.legend, colors: [.skyBlue, .blue, .red])
            .frame(width: 160)
            .aspectRatio(0.8, contentMode: .fit)
            .shadow(radius: 5)
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