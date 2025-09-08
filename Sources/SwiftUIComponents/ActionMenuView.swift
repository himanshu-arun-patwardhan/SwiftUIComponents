//
//  ActionMenuView.swift
//
//
//
//

import SwiftUI

// MARK: -
public enum ActionMenuIcon {
    case system(name: String)    /// SF Symbol
    case custom(image: Image)    /// Any SwiftUI Image
}

// MARK: -
public struct ActionMenuItem: Identifiable {
    public let id = UUID()
    public let title: String
    public let subtitle: String?
    public let icon: ActionMenuIcon?
    public let role: ButtonRole?
    public let isEnabled: Bool
    public let action: () -> Void
    
    public init(
        title: String,
        subtitle: String? = nil,
        icon: ActionMenuIcon? = nil,
        role: ButtonRole? = nil,
        isEnabled: Bool = true,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.subtitle = subtitle
        self.icon = icon
        self.role = role
        self.isEnabled = isEnabled
        self.action = action
    }
}

// MARK: -
public struct ActionMenuSection: Identifiable {
    public let id = UUID()
    public let title: String?
    public let items: [ActionMenuItem]
    
    public init(
        title: String? = nil,
        items: [ActionMenuItem]
    ) {
        self.title = title
        self.items = items
    }
}

// MARK: -
public struct ActionMenuView<LabelView: View>: View {
    private let sections: [ActionMenuSection]
    private let label: () -> LabelView
    ///
    public init(
        sections: [ActionMenuSection],
        @ViewBuilder label: @escaping () -> LabelView
    ) {
        self.sections = sections
        self.label = label
    }
    ///
    public init(
        items: [ActionMenuItem],
        @ViewBuilder label: @escaping () -> LabelView
    ) {
        self.sections = [ActionMenuSection(items: items)]
        self.label = label
    }
    
    public var body: some View {
        Menu {
            ForEach(sections) { section in
                if let header = section.title {
                    Section(header: Text(header)) {
                        sectionButtons(section.items)
                    }
                } else {
                    sectionButtons(section.items)
                }
            }
        } label: {
            label()
        }
    }
    
    // MARK: -
    @ViewBuilder
    private func sectionButtons(_ items: [ActionMenuItem]) -> some View {
        ForEach(items) { item in
            Button(role: item.role, action: item.action) {
                HStack(alignment: .firstTextBaseline, spacing: 6) {
                    if let icon = item.icon {
                        switch icon {
                        case .system(let name):
                            Image(systemName: name)
                        case .custom(let image):
                            image
                        }
                    }
                    
                    VStack(alignment: .leading, spacing: 2) {
                        Text(item.title)
                        if let subtitle = item.subtitle {
                            Text(subtitle)
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                    }
                }
            }
            .disabled(!item.isEnabled)
        }
    }
}
