//
//  ThanksChildView.swift
//  AHUer
//
//  Created by WeIHa'S on 2021/9/11.
//

import SwiftUI

struct ThanksChildView: View {
    var body: some View {
        VStack{
            Spacer()
            Text("Thanks to")
                .font(.title)
            Text("weiha")
                .font(.body)
                .padding()
            Text("Start at 2021-09-09")
            Spacer()
            Spacer()
        }
    }
}

struct ThanksChildView_Previews: PreviewProvider {
    static var previews: some View {
        ThanksChildView()
    }
}
