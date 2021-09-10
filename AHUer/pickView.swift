//
//  pickView.swift
//  AHUer
//
//  Created by WeIHa'S on 2021/9/10.
//

import SwiftUI

struct pickView: View {
    @Binding var selection: Int
    var titles: [String]
    
    var body: some View {
        HStack{
            ForEach(titles.indices) { index in
                tabButton(title: titles[index], isChoose: index == selection)
                    .onTapGesture {
                        withAnimation{
                            selection = index
                        }
                    }
            }
        }
        .aspectRatio(10, contentMode: .fit)
    }
    
    @ViewBuilder
    func tabButton(title: String, isChoose: Bool) -> some View {
        ZStack{
            RoundedRectangle(cornerRadius: 10)
                .stroke(lineWidth: 2)
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(isChoose ? .blue : .white)
            Text(title)
        }
    }
    
}

struct pickView_Previews: PreviewProvider {
    static var previews: some View {
        pickView(selection: .constant(1), titles: ["one","two","three","four"])
            .frame(width: 300, height: 10, alignment: .center)
    }
}
