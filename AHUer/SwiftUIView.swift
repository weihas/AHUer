//
//  SwiftUIView.swift
//  AHUer
//
//  Created by WeIHa'S on 2021/9/9.
//

import SwiftUI

struct SwiftUIView: View {
    var news: NewsItem
    var body: some View {
        VStack {
            Image("test")
                .resizable()
                .aspectRatio(contentMode: .fit)
            HStack {
                VStack(alignment: .leading) {
                    Text(news.title)
                        .font(.headline)
                        .foregroundColor(.secondary)
                    Text(news.author)
                        .font(.title)
                        .fontWeight(.black)
                        .foregroundColor(.primary)
                        .lineLimit(3)
                    Text(news.time)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                .layoutPriority(100)
                Spacer()
            }
            .padding()
        }
        .cornerRadius(15)
        .overlay(
            RoundedRectangle(cornerRadius: 15)
                .stroke(Color(.gray),lineWidth: 1)
                .shadow(color: Color.gray,radius: 2.0 ,x: 0 ,y: 2)
        )
        
        .padding()
    }
}


struct PopoverView: View {
    var body: some View {
        Text("Popover Content")
            .padding()
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView(news: NewsItem(id: 0, picture: UIImage(), title: "hello", author: "ookoko", time: "zuoye"))
    }
}
