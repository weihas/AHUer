//
//  AlertView.swift
//  AHUer
//
//  Created by WeIHa'S on 2022/3/10.
//

import Foundation
import SwiftUI

struct PresentView {
    
    private init(){}
    
    @MainActor
    static func show(vc: UIViewController, completion: @escaping (()->Void) = {}) {
        if let firstScene = UIApplication.shared.connectedScenes.first(where: {$0.activationState == .foregroundActive}) as? UIWindowScene {
            firstScene.keyWindow?.rootViewController?.present(vc, animated: true, completion: completion)
        }
    }
}


struct AlertView {
    private init(){}
    
    @MainActor
    static func showAlert(with error: Error) {
        if let error = error as? AHUerAPIError {
            showAlert(title: error.title, message: error.description)
        }
    }
    
    @MainActor
    static func showAlert(title: String, message: String? = nil, style: UIAlertController.Style = .alert, completion: @escaping (()->Void) = {}) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: style)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        HapticManager.responError()
        PresentView.show(vc: alertVC, completion: completion)
    }
    
    @MainActor
    static func showAlert(title: String, message: String? = nil, leftButton: @escaping(()->UIAlertAction), rightButton: @escaping(()->UIAlertAction)){
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(leftButton())
        alertVC.addAction(rightButton())
        PresentView.show(vc: alertVC)
    }
}


