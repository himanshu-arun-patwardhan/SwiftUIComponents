//
//  DeviceSizeClass.swift
//
//
//
//

import UIKit

@MainActor
public enum DeviceSizeClass {
    case small, medium, large
    
    public static func current(for width: CGFloat = UIScreen.screenWidth) -> DeviceSizeClass {
        switch width {
        case ..<375: return .small
        case 375..<768: return .medium
        default: return .large
        }
    }
}

/// how to use: -
/*
 switch DeviceSizeClass.current() {
 case .small: SmallView()
 case .medium: MediumView()
 case .large: LargeView()
 }
 */
