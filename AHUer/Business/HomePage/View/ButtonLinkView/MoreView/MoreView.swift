//
//  MoreView.swift
//  AHUer
//
//  Created by WeIHa'S on 2021/9/12.
//

import SwiftUI

struct MoreView: View {
    @ObservedObject var vm = MoreViewShow()
    let gridItems = Array(repeating: GridItem(.flexible(minimum: 50)), count: 4)
    
    var body: some View {
        ScrollView{
            VStack(alignment: .leading) {
                cardModel(infos: vm.cardInfoForStudy, name: "学习", icon: "graduationcap.fill")
                cardModel(infos: vm.cardInfoForLife, name: "生活", icon: "scribble.variable")
            }
            .padding()
        }
        
        .navigationTitle("更多功能")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    @ViewBuilder
    func cardModel(infos: [HomePageFunc], name: String, icon: String) -> some View {
        GroupBox(label: Label(name, systemImage: icon)) {
            LazyVGrid(columns: gridItems){
                ForEach(infos){ info in
                    CardOfMoreView(viewModel: vm, info: info)
                        .aspectRatio(0.6, contentMode: .fit)
                }
            }
        }
        .groupBoxStyle(MoreBoxStyle())
    }
}


fileprivate struct CardOfMoreView: View {
    var viewModel: MoreViewShow
    let info: HomePageFunc
    var body: some View {
        NavigationLink {
            distinationView()
        } label: {
            RoundedRectangle(cornerRadius: 20)
                .fill(info.color.opacity(0.2))
                .overlay(
                    VStack{
                        Image(systemName: info.funcIcon)
                            .font(.largeTitle)
                        Text(info.funcName)
                    }.foregroundColor(info.color)
                )
        }
    }
    
    @ViewBuilder
    private func distinationView()  -> some View {
        switch info {
        case .emptyRoom :
            EmptyRoomView(vm: viewModel.emptyClassVM)
        case .scoreSearch:
            ScoreView(vm: viewModel.scoreViewVM)
        case .examSearh:
            ExamSiteView(vm: viewModel.examSiteVM)
        case .bathroom:
            BathView(vm: viewModel.bathInfoVM)
        case .distribution:
            DistributionView(vm: viewModel.distributionVM)
        case .addressbook:
            AddressBookView(vm: viewModel.addressBookVM)
        default:
            fatalError("Shoud never dirveIn")
        }
    }
}



struct MoreView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
//            MoreView()
//                .previewDevice("iPad Pro (11-inch) (3rd generation)")
            MoreView()
                .previewDevice("iPhone 13 mini")
        }
    }
}
