//
//  StyledButton.swift
//
//
//
//

import SwiftUI

public struct StyledButton: ComponentViewProtocol {
    public let title: String
    public let titleColor: Color
    public let backgroundColor: Color
    public let cornerRadius: CGFloat
    public let font: Font
    public let frameWidth: CGFloat?
    public let frameHeight: CGFloat?
    public let borderColor: Color?
    public let borderWidth: CGFloat?
    public let action: () -> Void
    
    public init(
        title: String,
        titleColor: Color = ComponentTheme.Colors.textPrimary,
        backgroundColor: Color = ComponentTheme.Colors.textPrimary,
        cornerRadius: CGFloat = ComponentTheme.Radius.medium,
        font: Font = ComponentTheme.Fonts.button,
        frameWidth: CGFloat? = nil,
        frameHeight: CGFloat? = nil,
        borderColor: Color? = nil,
        borderWidth: CGFloat? = nil,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.titleColor = titleColor
        self.backgroundColor = backgroundColor
        self.cornerRadius = cornerRadius
        self.font = font
        self.frameWidth = frameWidth
        self.frameHeight = frameHeight
        self.borderColor = borderColor
        self.borderWidth = borderWidth
        self.action = action
    }
    
    public var body: some View {
        Button(action: action) {
            Text(title)
                .font(font)
                .foregroundStyle(titleColor)
                .frame(maxWidth: .infinity)
                .frame(width: frameWidth, height: frameHeight)
                .padding(10)
                .background(backgroundColor)
                .cornerRadius(cornerRadius)
                .overlay(
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .stroke(borderColor ?? .clear, lineWidth: borderWidth ?? 0)
                )
        }
    }
}
