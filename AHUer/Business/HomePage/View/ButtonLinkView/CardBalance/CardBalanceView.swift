//
//  CardBalanceView.swift
//  AHUer
//
//  Created by WeIHa'S on 2022/4/17.
//

import SwiftUI

struct CardBalanceView: View {
    @ObservedObject var vm: CardBalanceShow
    @State var show: Bool = false
    var body: some View {
        VStack {
            card
            detailView
            Spacer()
        }
        .onAppear {
            vm.freshWithLoacl()
        }
        .refreshable {
            await vm.freshwithInternet()
        }
    }
    
    var card: some View {
        RoundedRectangle(cornerRadius: 20)
            .fill(LinearGradient(gradient: Gradient(colors: [.babyPuerple, .meiOrange]), startPoint: .bottomLeading, endPoint: .topTrailing))
            .aspectRatio(1.618, contentMode: .fit)
            .shadow(radius: 5)
            .opacity(0.8)
            .overlay(alignment: .topLeading) {
                VStack(alignment: .leading) {
                    Text(vm.moneyTitle)
                        .font(.custom("American Typewriter", fixedSize: 30))
                    Spacer()
                    Text(vm.userName)
                        .font(.custom("Zapfino", size: 15))
                }
                .onAppear{
                    withAnimation(.easeInOut) {
                        show.toggle()
                    }
                }
                .padding(20)
                .foregroundColor(.white)
            }
            .overlay(alignment: .bottomTrailing) {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.silver)
                    .background {
                        LazyVGrid(columns: Array(repeating: GridItem(.flexible(minimum: 2)), count: 2), spacing: 2) {
                            ForEach(0..<6) { index in
                                Capsule()
                                    .stroke(Color.white ,lineWidth: 1)
                                    .frame(width: 18, height: 8)
                            }
                        }
                        .padding(5)
                    }
                    .onTapGesture {
                        withAnimation {
                            show.toggle()
                        }
                    }
                    .frame(width: 50, height: 35)
                    .padding()
                    .padding(.bottom, 60)
                    .opacity(0.5)
            }
            .rotation3DEffect(Angle(degrees: show ? 360 : 0), axis: (x: 1.0, y: 1.0, z: 1.0))
            .padding()
    }
    
    var detailView: some View {
        List {
            Section {
                Text(vm.moneyTitle)
            } header: {
                Text("余额")
            }
            if let trasition = vm.transitionBalanceTitle {
                Section {
                    Text(trasition)
                } header: {
                    Text("待圈存")
                }
            }
           
        }
        .listStyle(.plain)
    }
}

//struct CardBalanceView_Previews: PreviewProvider {
//    static var previews: some View {
//        CardBalanceView()
//    }
//}
