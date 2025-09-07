//
//  ComponentViewProtocol.swift
//
//
//
//

import SwiftUI

/// shared base protocol for all reusable UI components in the package.
/// ensures consistency and discoverability across views.
/// provides default behaviours
public protocol ComponentViewProtocol: View where Body: View {
    var body: Self.Body { get }
}

// MARK: -
/// extension to provide reusable styles.
public extension ComponentViewProtocol {
    /// Default corner radius for all components
    var defaultCornerRadius: CGFloat { ComponentTheme.Radius.medium }
    
    /// Default shadow style for all components
    var defaultShadow: some View {
        self.shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
    }
}
