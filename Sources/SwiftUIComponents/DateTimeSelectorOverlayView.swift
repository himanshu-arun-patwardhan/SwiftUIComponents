//
//  DateTimeSelectorOverlayView.swift
//
//
//
//

import SwiftUI
import UIKit

public struct DateTimeSelectorOverlayView: ComponentViewProtocol {
    public let title: String
    public let defaultDate: Date
    public let minDate: Date
    public let maxDate: Date
    public let components: DatePickerComponents
    public let onDateSelected: (Date) -> Void
    public let onDismiss: () -> Void
    
    @State private var selectedDate: Date
    
    public init(
        title: String,
        defaultDate: Date = Date(),
        minDate: Date? = nil,
        maxDate: Date? = nil,
        components: DatePickerComponents = [.date],
        onDateSelected: @escaping (Date) -> Void,
        onDismiss: @escaping () -> Void
    ) {
        let today = Date()
        let threeMonthsAgo = Calendar.current.date(byAdding: .month, value: -3, to: today)!
        
        self.title = title
        self.defaultDate = defaultDate
        self.minDate = minDate ?? threeMonthsAgo
        self.maxDate = maxDate ?? today
        self.components = components
        self.onDateSelected = onDateSelected
        self.onDismiss = onDismiss
        
        let clamped = min(max(defaultDate, self.minDate), self.maxDate)
        _selectedDate = State(initialValue: clamped)
    }
    
    public var body: some View {
        ZStack {
            ///
            ComponentTheme.Colors.overlayBackground
                .ignoresSafeArea()
                .onTapGesture {
                    dismissWithHaptic()
                }
            ///
            VStack(spacing: ComponentTheme.Spacing.medium) {
                ///
                Text(title)
                    .font(ComponentTheme.Fonts.title)
                    .foregroundColor(ComponentTheme.Colors.textPrimary)
                ///
                buildDateTimePickerView()
                    .onChange(of: selectedDate) { newValue in
                        haptic()
                        onDateSelected(newValue)
                        onDismiss()
                    }
                    .padding(.bottom, ComponentTheme.Spacing.small)
                ///
                Button("Cancel") {
                    dismissWithHaptic()
                }
                .foregroundColor(ComponentTheme.Colors.error)
                .font(ComponentTheme.Fonts.button)
                .padding(.top, ComponentTheme.Spacing.small)
            }
            .padding()
            .background(ComponentTheme.Colors.background)
            .cornerRadius(ComponentTheme.Radius.large)
            .frame(maxWidth: 350)
            .shadow(radius: 10)
            .transition(.scale.combined(with: .opacity))
            .animation(.spring(), value: selectedDate)
        }
    }
    
    @ViewBuilder
    private func buildDateTimePickerView() -> some View {
        if components == .date {
            DatePicker(
                "",
                selection: $selectedDate,
                in: minDate...maxDate,
                displayedComponents: .date
            )
            .datePickerStyle(GraphicalDatePickerStyle())
            .labelsHidden()
        } else {
            DatePicker(
                "",
                selection: $selectedDate,
                in: minDate...maxDate,
                displayedComponents: components
            )
            .datePickerStyle(WheelDatePickerStyle())
            .labelsHidden()
        }
    }
    
    // MARK: - Helpers
    private func haptic() {
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
    }
    
    private func dismissWithHaptic() {
        haptic()
        onDismiss()
    }
}
