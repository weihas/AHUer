//
//  TableClassCell.swift
//  AHUer
//
//  Created by WeIHa'S on 2021/9/24.
//

import SwiftUI

struct TableClassCell: View {
    var tablecellModel: TableClassCellModel
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 5).foregroundColor(.clear)
            if tablecellModel.isShow{
                RoundedRectangle(cornerRadius: 5).foregroundColor(.blue)
                VStack{
                    Text(tablecellModel.name)
                    Text(tablecellModel.location)
                }
                .font(.footnote)
            }
        }
        .aspectRatio(tablecellModel.lectureLengthisTwo ? 0.5 : 1, contentMode: .fit)
    }
}

//struct TableClassCellView_Previews: PreviewProvider {
//    static var previews: some View {
//        TableClassCellView()
//    }
//}
