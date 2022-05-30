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
    @State var isFocused: Bool = false
    var body: some View {
        ScrollView {
            searchBar
            bodyCards
            Spacer()
        }
        .onDisappear {
            vm.clearModel()
        }
        .navigationTitle("成绩分布")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    var bodyCards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 160), spacing: 10)]) {
            ForEach(vm.distributions) { distribution in
                DistributionCard(content: distribution)
            }
        }
    }
    
    var searchBar: some View{
        VStack {
            TextField("输入课程名称", text: $vm.courseName)
            .padding()
            .background(Capsule().stroke(Color.meiRed).padding(10))
            .onSubmit {
                vm.getDistribution()
            }
            .overlay(alignment: .trailing) {
                if vm.showSearch {
                    Button {
                        vm.getDistribution()
                        withAnimation {
                            isFocused.toggle()
                        }
                    } label: {
                        Image(systemName: "magnifyingglass")
                            .font(.system(size: 20))
                            .padding(.trailing)
                    }
                    
                }
            }
            Divider()
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 90))]){
                ForEach(0..<vm.tipsRegularly.count, id: \.self){ index in
                    let name = vm.tipsRegularly[index]
                    Button(name) {
                        vm.courseName = name
                        vm.getDistribution()
                    }
                    .lineLimit(1)
                    .padding(.horizontal)
                    .padding(.vertical,5)
                    .background(Capsule().fill(Color.skyBlue).shadow(radius: 2))
                    
                }
            }
            .padding()
  
        }
        .onTapGesture {
            withAnimation{
                isFocused = true
            }
        }
    }
}

fileprivate struct DistributionCard: View{
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
        let vm = DistributionShow()
        vm.distributions = [Distribution(id: "CG12345", name: "高等数学", moreThan80: 0.45, moreThan60: 0.90),
                            Distribution(id: "CG12345", name: "这是一个测试", moreThan80: 0.45, moreThan60: 0.90)]
        return DistributionView(vm: vm)
    }
}
