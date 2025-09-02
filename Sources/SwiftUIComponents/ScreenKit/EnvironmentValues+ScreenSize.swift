//
//  EnvironmentValues+ScreenSize.swift
//
//
//
//

import SwiftUI

@MainActor
private struct ScreenSizeKey: @preconcurrency EnvironmentKey {
    static let defaultValue: CGSize = UIScreen.main.bounds.size
}

public extension EnvironmentValues {
    var screenSize: CGSize {
        self[ScreenSizeKey.self]
    }
    
    var screenWidth: CGFloat { screenSize.width }
    var screenHeight: CGFloat { screenSize.height }
}

// MARK: -
private struct SafeAreaInsetsKey: EnvironmentKey {
    static let defaultValue: EdgeInsets = .init()
}

public extension EnvironmentValues {
    var safeAreaInsets: EdgeInsets {
        self[SafeAreaInsetsKey.self]
    }
}

/// how to use: -
/// inject it app entry
/*
 RootView()
 .environment(\.screenSize, UIScreen.screenSize)
 .environment(\.safeAreaInsets, EdgeInsets(UIApplication.safeAreaInsets))
 */
