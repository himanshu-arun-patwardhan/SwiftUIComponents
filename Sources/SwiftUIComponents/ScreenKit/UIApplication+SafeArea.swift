//
//  UIApplication+SafeArea.swift
//
//
//
//

import UIKit

@MainActor
public extension UIApplication {
    static var safeAreaInsets: UIEdgeInsets {
        UIApplication.shared.connectedScenes
            .compactMap { ($0 as? UIWindowScene)?.keyWindow?.safeAreaInsets }
            .first ?? .zero
    }
}
