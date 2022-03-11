//
//  Popup.swift
//  AHUer
//
//  Created by WeIHa'S on 2021/11/25.
//

import Foundation
import SwiftUI

public struct Popup<T: View>: ViewModifier {
    public enum PopUpStyle{
        case small
        case middle
        case big
    }
    @ViewBuilder private let popup: () -> T
    @Binding var isPresented: Bool
    
    private var style: PopUpStyle = .small

    var height: Double {
        switch style {
        case .small:
            return 300
        case .middle:
            return 400
        case .big:
            return 500
        }
    }
    
    init(isPresented: Binding<Bool> , context: @escaping () -> T){
        self._isPresented = isPresented
        self.popup = context
    }
    
    public func body(content: Content) -> some View {
        content
            .onTapGesture {
                self.isPresented = false
            }
            .overlay(popupContext())
    }
    
    @ViewBuilder private func popupContext() -> some View {
        VStack{
            Spacer()
                if isPresented {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color(.systemBackground))
                        .shadow(color: .gray.opacity(0.5), radius: 2)
                        .overlay(VStack{popup().cornerRadius(20)})
                        .overlay(
                            HStack{
                                Spacer()
                                Button(action: {
                                    isPresented = false
                                }, label: {
                                    Image(systemName: "multiply.circle.fill")
                                        .font(.system(size: 25))
                                })
                                    .foregroundColor(.gray)
                                   
                            }
                                .padding(.top, -145)
                                .padding(5)
                        )
                        .transition(.move(edge: .bottom))
                        .animation(.default)
                        .frame(maxWidth: .infinity, maxHeight: height, alignment: .bottom)
                }
        }
    }
}

extension View {
    func popup<T: View>(isPresented: Binding<Bool> ,@ViewBuilder context: @escaping () -> T) -> some View{
        return modifier(Popup(isPresented: isPresented.projectedValue, context: context))
    }
}


extension View{
    func border() -> some View{
        return self.border(Color.black, width: 1)
    }
}
