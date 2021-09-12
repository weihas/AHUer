//
//  CoolTest.swift
//  AHUer
//
//  Created by WeIHa'S on 2021/9/11.
//

import SwiftUI

struct CoolTest: View {
    @State var isTab: Bool = false
    @State var showContent: Bool = false
    @ObservedObject var vm: NewsPlaying = NewsPlaying()
    @Namespace var namespace
    
    var body: some View {
        List(vm.news){news in 
            SwiftUIView(news: news)
                .matchedGeometryEffect(id: 2, in: namespace)
                .onTapGesture {
                    withAnimation{
                        isTab = true
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3){
                        isTab = false
                        showContent = true
                    }
                }
                .scaleEffect(isTab ? 0.8 : 1)
                .popover(isPresented: $showContent, attachmentAnchor: .point(.center), arrowEdge: .leading, content: {
                    Text("hello")
                })
            
        }
    }
}


struct CoolTest_Previews: PreviewProvider {
    static var previews: some View {
        CoolTest()
    }
}
