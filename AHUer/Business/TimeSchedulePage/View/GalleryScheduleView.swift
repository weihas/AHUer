//
//  GalleryScheduleView.swift
//  AHUer
//
//  Created by WeIHa'S on 2022/2/28.
//

import SwiftUI

struct GalleryScheduleView: View {
    var body: some View {
        ScrollView{
            CardOfGallery()
                .aspectRatio(2, contentMode: .fit)
        }
    }
}


struct CardOfGallery: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 20)
            .fill(Color.blue)
    }
}

struct GallerySchedule_Previews: PreviewProvider {
    static var previews: some View {
        GalleryScheduleView()
    }
}
