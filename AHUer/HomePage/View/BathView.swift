//
//  BathView.swift
//  AHUer
//
//  Created by WeIHa'S on 2021/9/9.
//

import SwiftUI

struct BathView: View {
    var body: some View {
        VStack{
            ScrollView{
                VStack{
                    Text("hello")
                }
            }
            .navigationBarTitle("浴室开放",displayMode: .inline)
        }
    }
}

struct BathView_Previews: PreviewProvider {
    static var previews: some View {
        BathView()
    }
}
