//
//  ComponentTheme.swift
//
//
//
//

import SwiftUI

public struct ComponentTheme {
    
    // MARK: - Colors
    public struct Colors {
        public static let primary = Color.blue
        public static let secondary = Color.gray
        public static let error = Color.red
        public static let success = Color.green
        public static let background = Color.white
        public static let textPrimary = Color.black
        public static let textSecondary = Color.gray
        public static let overlayBackground = Color.black.opacity(0.7)
    }
    
    // MARK: - Typography
    public struct Fonts {
        public static let title = Font.title2.weight(.bold)
        public static let subtitle = Font.subheadline
        public static let body = Font.body
        public static let button = Font.headline
    }
    
    // MARK: - Spacing
    public struct Spacing {
        public static let small: CGFloat = 8
        public static let medium: CGFloat = 16
        public static let large: CGFloat = 24
    }
    
    // MARK: - Radius
    public struct Radius {
        public static let small: CGFloat = 8
        public static let medium: CGFloat = 12
        public static let large: CGFloat = 20
    }
}
