//
//  InputFieldView.swift
//
//
//
//

import SwiftUI

public struct InputFieldView: ComponentViewProtocol {
    @Binding private var text: String
    /// externally managed focus state
    @FocusState.Binding private var isFocused: Bool
    
    private let placeholder: String
    private let leftIcon: String?
    private let rightButtonTitle: String?
    private let onRightButtonTap: (() -> Void)?
    private let characterLimit: Int
    private let onTextChange: (String) -> Bool
    private let returnKeyType: UIReturnKeyType
    private let onReturn: () -> Void
    private let font: Font
    private let width: CGFloat?
    private let height: CGFloat?
    private let enableHaptics: Bool
    
    public init(
        text: Binding<String>,
        placeholder: String = "",
        leftIcon: String? = nil,
        rightButtonTitle: String? = nil,
        onRightButtonTap: (() -> Void)? = nil,
        characterLimit: Int = .max,
        onTextChange: @escaping (String) -> Bool = { _ in true },
        returnKeyType: UIReturnKeyType = .default,
        onReturn: @escaping () -> Void = {},
        isFocused: FocusState<Bool>.Binding,
        font: Font = .body,
        width: CGFloat? = nil,
        height: CGFloat? = nil,
        enableHaptics: Bool = true
    ) {
        self._text = text
        self.placeholder = placeholder
        self.leftIcon = leftIcon
        self.rightButtonTitle = rightButtonTitle
        self.onRightButtonTap = onRightButtonTap
        self.characterLimit = characterLimit
        self.onTextChange = onTextChange
        self.returnKeyType = returnKeyType
        self.onReturn = onReturn
        self._isFocused = isFocused
        self.font = font
        self.width = width
        self.height = height
        self.enableHaptics = enableHaptics
    }
    
    public var body: some View {
        HStack {
            ///
            if let iconName {
                Image(systemName: iconName)
                    .frame(width: 30, height: 30)
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(.gray)
            }
            ///
            TextField(
                placeholder,
                text: Binding(
                    get: { text },
                    set: { newValue in
                        if newValue.count <= characterLimit {
                            text = newValue
                            _ = onTextChange(newValue)
                        } else if enableHaptics {
                            /// haptic feedback
                            UIImpactFeedbackGenerator(style: .light).impactOccurred()
                        }
                    }
                )
            )
            .focused($isFocused)
            .font(font)
            .textInputAutocapitalization(.none)
            .disableAutocorrection(true)
            .submitLabel(returnKeyType.toSubmitLabel())
            .onSubmit {
                onReturn()
            }
            ///
            if let rightButtonTitle, let onRightButtonTap {
                Button(action: onRightButtonTap) {
                    Text(rightButtonTitle)
                        .foregroundColor(.blue)
                }
            }
        }
        .padding()
        .frame(width: width, height: height)
        .background(
            RoundedRectangle(cornerRadius: ComponentTheme.Radius.small)
                .stroke(ComponentTheme.Colors.border, lineWidth: 2)
        )
        .padding(.horizontal)
        .id("InputFieldView") /// For scroll-to-view support
    }
}

// MARK: - UIReturnKeyType to SubmitLabel Mapping
public extension UIReturnKeyType {
    func toSubmitLabel() -> SubmitLabel {
        switch self {
        case .go: return .go
        case .join: return .join
        case .next: return .next
        case .route: return .route
        case .search: return .search
        case .send: return .send
        case .done: return .done
        case .continue: return .continue
        default: return .return
        }
    }
}
