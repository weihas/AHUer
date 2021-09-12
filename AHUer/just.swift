//
//  just.swift
//  AHUer
//
//  Created by WeIHa'S on 2021/9/11.
//

import SwiftUI
struct just: View {
    @State var coverData: CoverData?
    var body: some View {
        HStack {
                   ForEach(0..<6) {
                       Color.red.frame(width: 60, height: 60, alignment: .center)
                           .overlay(Text("\($0)"),
                                    alignment: .bottom)
                           .shadow(color: Color.gray,
                                   radius: 1.0,
                                   x: CGFloat($0),
                                   y: CGFloat($0))
                   }
               }
    }

    func didDismiss() {
        // Handle the dismissing action.
    }

}

struct CoverData: Identifiable {
    var id: String {
        return body
    }
    let body: String
}

struct just_Previews: PreviewProvider {
    static var previews: some View {
        just()
    }
}
