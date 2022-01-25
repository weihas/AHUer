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
                Task{
                    do {
                        try await vm.getDistribution(courseName: courseName)
                    } catch {
                        appInfo.showAlert(with: error)
                    }
                }
            }
                .padding()
            
            .background(Capsule().stroke(Color.meiRed).padding(5))
            .overlay(
                HStack{
                    if show {
                        Spacer()
                        Button {
                            Task{
                                do {
                                    try await vm.getDistribution(courseName: courseName)
                                } catch {
                                    appInfo.showAlert(with: error)
                                }
                            }
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
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 80))]){
                ForEach(0..<vm.tipsRegularly.count){ index in
                    let name = vm.tipsRegularly[index]
                    Button(name) {
                        Task{
                            do {
                                try await vm.getDistribution(courseName: name)
                            } catch {
                                appInfo.showAlert(with: error)
                            }
                        }
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

fileprivate struct DistributionCard: View{
    let content: Distribution
    var body: some View {
        VStack{
            HStack{
                Text(content.name)
                Text(content.id)
            }
            Text("\(content.moreThan80)")
            Text("\(content.between60and80)")
            Text("\(content.moreThan60)")
        }
    }
}

struct DistributionView_Previews: PreviewProvider {
    static var previews: some View {
        DistributionView(vm: DistributionShow())
    }
}