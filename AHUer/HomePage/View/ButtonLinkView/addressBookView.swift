//
//  addressBookView.swift
//  AHUer
//
//  Created by WeIHa'S on 2021/9/10.
//

import SwiftUI

struct addressBookView: View {
    var body: some View {
        HStack{
            List {
                Button("你好"){
                    print("hello")
                }
            }
            List {
                
            }
        }
       
    }
}

struct addressBookView_Previews: PreviewProvider {
    static var previews: some View {
        addressBookView()
    }
}
