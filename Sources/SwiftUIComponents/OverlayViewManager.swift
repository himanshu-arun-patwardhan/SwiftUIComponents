//
//  OverlayViewManager.swift
//
//
//
//

import SwiftUI

@MainActor
public class OverlayViewManager: ObservableObject {
    public static let shared = OverlayViewManager()
    private init() {}
    
    @Published public var currentOverlay: AnyView? = nil
    
    public func show<Content: View>(_ view: Content) {
        DispatchQueue.main.async {
            self.currentOverlay = AnyView(view)
        }
    }
    
    public func dismiss() {
        DispatchQueue.main.async {
            self.currentOverlay = nil
        }
    }
}
