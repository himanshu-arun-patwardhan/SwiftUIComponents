//
//  AlertOverlayView.swift
//
//
//
//

import SwiftUI

public struct AlertOverlayView: ComponentViewProtocol {
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
            ComponentTheme.Colors.blurWhiteBackground
                .edgesIgnoringSafeArea(.all)
                .onTapGesture {
                    onDismiss()
                    OverlayViewManager.shared.dismiss()
                }
            ///
            VStack(spacing: ComponentTheme.Spacing.medium) {
                ///
                Text(title)
                    .font(.headline)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, ComponentTheme.Padding.mediumLarge)
                ///
                Text(subtitle)
                    .font(.subheadline)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, ComponentTheme.Padding.mediumLarge)
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
                        .cornerRadius(ComponentTheme.Radius.small)
                }
            }
            .padding()
            .frame(width: 280)
            .background(
                RoundedRectangle(cornerRadius: ComponentTheme.Radius.large)
                    .fill(ComponentTheme.Colors.blurWhiteBackground)
                    .shadow(radius: 10)
            )
        }
    }
}
