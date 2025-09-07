//
//  LoadingView.swift
//
//
//
//

import SwiftUI

public struct LoadingView: ComponentViewProtocol {
    public var message: String?
    
    public init(message: String? = nil) {
        self.message = message
    }
    
    public var body: some View {
        ZStack {
            ///
            Color.black.opacity(0.4)
                .ignoresSafeArea()
            /// spinner and message
            VStack(spacing: ComponentTheme.Spacing.medium) {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                //                    .scaleEffect(1.5)
                
                if let message {
                    Text(message)
                        .foregroundColor(.white)
                        .font(.headline)
                }
            }
            .padding(ComponentTheme.Padding.xLarge)
            .background(ComponentTheme.Colors.blurGrayBackground)
            .cornerRadius(ComponentTheme.Radius.mediumLarge)
        }
        .transition(.opacity)
    }
}
