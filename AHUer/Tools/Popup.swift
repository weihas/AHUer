//
//  Popup.swift
//  AHUer
//
//  Created by admin on 2021/11/25.
//

import Foundation
import SwiftUI

public struct Popup<T: View>: ViewModifier {
    let popup: T
    @Binding var isPresented: Bool
    
    init(isPresented: Binding<Bool> ,@ViewBuilder context: () -> T){
        self._isPresented = isPresented
        self.popup = context()
    }
    
    public func body(content: Content) -> some View {
        content
            .onTapGesture {
                withAnimation{
                    self.isPresented = false
                }
            }
            .overlay(popupContext())
    }
    
    @ViewBuilder private func popupContext() -> some View {
        GeometryReader { geometry in
            if isPresented {
                popup
                    .cornerRadius(20)
                    .transition(.opacity.combined(with: .move(edge: .bottom)))
                    .frame(width: geometry.size.width, height: geometry.size.height, alignment: .bottom)
            }
        }
    }
}

extension View {
    func popup<T: View>(isPresented: Binding<Bool> ,@ViewBuilder context: () -> T) -> some View{
        return modifier(Popup(isPresented: isPresented.projectedValue, context: context))
    }
}

extension View{
    func border() -> some View{
        return self.border(Color.black, width: 1)
    }
}
