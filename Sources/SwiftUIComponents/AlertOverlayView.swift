//
//  AlertOverlayView.swift
//
//
//
//

import SwiftUI

public struct AlertOverlayView: View {
    public var title: String
    public var subtitle: String
    public var buttonText: String
    public var onDismiss: () -> Void
    
    public init(
        title: String,
        subtitle: String,
        buttonText: String,
        onDismiss: @escaping () -> Void
    ) {
        self.title = title
        self.subtitle = subtitle
        self.buttonText = buttonText
        self.onDismiss = onDismiss
    }
    
    public var body: some View {
        ZStack(alignment: .center) {
            ///
            Color.white.opacity(0.8)
                .edgesIgnoringSafeArea(.all)
                .onTapGesture {
                    onDismiss()
                    OverlayViewManager.shared.dismiss()
                }
            ///
            VStack(spacing: 16) {
                ///
                Text(title)
                    .font(.headline)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 20)
                ///
                Text(subtitle)
                    .font(.subheadline)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 20)
                ///
                Button(action: {
                    onDismiss()
                    OverlayViewManager.shared.dismiss()
                }) {
                    Text(buttonText)
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(.black)
                        .cornerRadius(10)
                }
            }
            .padding()
            .frame(width: 280)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.white.opacity(0.9))
                    .shadow(radius: 10)
            )
        }
    }
}
