//
//  DateTimeSelectorOverlayView.swift
//
//
//
//

import SwiftUI

public enum DateTimePickerMode {
    case date
    case time
    case dateTime
}

public struct ComponentDateTimeSelector: ComponentViewProtocol {
    public let title: String
    public let defaultDate: Date
    public let minDate: Date
    public let maxDate: Date
    public let mode: DateTimePickerMode
    public let onDateSelected: (Date) -> Void
    public let onDismiss: () -> Void
    
    @State private var selectedDate: Date
    
    public init(
        title: String,
        defaultDate: Date = Date(),
        minDate: Date? = nil,
        maxDate: Date? = nil,
        mode: DateTimePickerMode = .date,
        onDateSelected: @escaping (Date) -> Void,
        onDismiss: @escaping () -> Void
    ) {
        let today = Date()
        let threeMonthsAgo = Calendar.current.date(byAdding: .month, value: -3, to: today)!
        
        self.title = title
        self.defaultDate = defaultDate
        self.minDate = minDate ?? threeMonthsAgo
        self.maxDate = maxDate ?? today
        self.mode = mode
        self.onDateSelected = onDateSelected
        self.onDismiss = onDismiss
        
        let clamped = min(max(defaultDate, self.minDate), self.maxDate)
        _selectedDate = State(initialValue: clamped)
    }
    
    public var body: some View {
        ZStack {
            ///
            ComponentTheme.Colors.blurBlackBackground
                .ignoresSafeArea()
                .onTapGesture { dismissWithHaptic() }
            ///
            VStack(spacing: ComponentTheme.Spacing.medium) {
                ///
                Text(title)
                    .font(.headline)
                ///
                dateTimePickerView()
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
            .shadow(radius: ComponentTheme.Radius.small)
            .transition(.scale.combined(with: .opacity))
            .animation(.spring(), value: selectedDate)
        }
    }
    
    // MARK: -
    @ViewBuilder
    private func dateTimePickerView() -> some View {
        switch mode {
        case .date:
            DatePicker(
                "",
                selection: $selectedDate,
                in: minDate...maxDate,
                displayedComponents: .date
            )
            .datePickerStyle(GraphicalDatePickerStyle())
            .labelsHidden()
            
        case .time:
            DatePicker(
                "",
                selection: $selectedDate,
                in: minDate...maxDate,
                displayedComponents: .hourAndMinute
            )
            .datePickerStyle(WheelDatePickerStyle())
            .labelsHidden()
            
        case .dateTime:
            DatePicker(
                "",
                selection: $selectedDate,
                in: minDate...maxDate,
                displayedComponents: [.date, .hourAndMinute]
            )
            .datePickerStyle(WheelDatePickerStyle())
            .labelsHidden()
        }
    }
    
    private func haptic() {
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
    }
    
    private func dismissWithHaptic() {
        haptic()
        onDismiss()
    }
}
