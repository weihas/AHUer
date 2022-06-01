//
//  Haptic+Extension.swift
//  AHUer
//
//  Created by WeIHa'S on 2022/5/31.
//

import Foundation
import CoreHaptics
import UIKit

class HapticManager {
    let hapticEngine: CHHapticEngine
    
    
    init?() {
        let hapticCapability = CHHapticEngine.capabilitiesForHardware()
        guard hapticCapability.supportsHaptics else {
            return nil
        }
        
        do {
            hapticEngine = try CHHapticEngine()
        } catch {
            print("Haptic engine Creation Error: \(error)")
            return nil
        }
        
        
    }
}

public enum FeedBackType: Int {
    case light
    case medium
    case heavy
    case success
    case waring
    case error
    case none
}


extension HapticManager {
    static func impactFeedBack(style: FeedBackType) {
        switch style {
        case .light:
            let generator = UIImpactFeedbackGenerator(style: .light)
            generator.impactOccurred()
        case .medium:
            let generator = UIImpactFeedbackGenerator(style: .medium)
            generator.impactOccurred()
        case .heavy:
            let generator = UIImpactFeedbackGenerator(style: .heavy)
            generator.impactOccurred()
        case .success:
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.success)
        case .waring:
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.warning)
        case .error:
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.error)
        case .none:
            break
        }
    }
    
    static func responBack(status: Bool?) {
        guard let status = status else { return }
        if status {
            impactFeedBack(style: .success)
        } else {
            if UserDefaults.standard.bool(forKey: AHUerDefaultsKey.Haptic_Error_Active.rawValue) {
                impactFeedBack(style: .error)
            }
        }
    }
    
    static func responError(){
        impactFeedBack(style: .error)
    }
    
    static func responSuccess() {
        if UserDefaults.standard.bool(forKey: AHUerDefaultsKey.Haptic_Success_Active.rawValue) {
            impactFeedBack(style: .success)
        }
    }
}
