//
//  OverlayViewManager.swift
//
//
//
//

import SwiftUI

@MainActor
class OverlayViewManager: ObservableObject {
    static let shared = OverlayViewManager()
    
    @Published var currentOverlay: AnyView? = nil
    
    func show<Content: View>(_ view: Content) {
        DispatchQueue.main.async {
            self.currentOverlay = AnyView(view)
        }
    }
    
    func dismiss() {
        DispatchQueue.main.async {
            self.currentOverlay = nil
        }
    }
}
