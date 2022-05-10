//
//  AboutUSView.swift
//  AHUer
//
//  Created by WeIHa'S on 2022/2/20.
//

import SwiftUI

struct AboutUSView: View {
    var body: some View {
        List {
            ForEach(ContributeType.allCases) { type in
                Section {
                    ForEach(type.member, id: \.self) { m in
                        Text(m)
                    }
                } header: {
                    Label(type.name, systemImage: type.icon)
                }
            }
            
        }
        .listStyle(.inset)
        .navigationTitle("关于我们")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct AboutUSView_Previews: PreviewProvider {
    static var previews: some View {
        AboutUSView()
    }
}
