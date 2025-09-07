//
//  BannerView.swift
//
//
//
//

import SwiftUI

// MARK: - BannerType
public enum BannerType {
    case success, error, info, warning
    
    public var backgroundColor: Color {
        switch self {
        case .success: return .green
        case .error: return .red
        case .info: return .blue
        case .warning: return .yellow
        }
    }
    
    public var icon: Image {
        switch self {
        case .success: return Image(systemName: "checkmark.circle.fill")
        case .error: return Image(systemName: "xmark.octagon.fill")
        case .info: return Image(systemName: "info.circle.fill")
        case .warning: return Image(systemName: "exclamationmark.triangle.fill")
        }
    }
}

public enum BannerPosition {
    case top, bottom
}

// MARK: - BannerData
public struct BannerData: Equatable {
    public var type: BannerType
    public var title: String?
    public var subtitle: String?
    public var duration: TimeInterval
    public var position: BannerPosition
    
    public init(
        type: BannerType = .info,
        title: String? = nil,
        subtitle: String? = nil,
        duration: TimeInterval = 5.0,
        position: BannerPosition = .top
    ) {
        self.type = type
        self.title = title
        self.subtitle = subtitle
        self.duration = duration
        self.position = position
    }
}

// MARK: - BannerManager
@MainActor
public final class BannerManager: ObservableObject {
    public static let shared = BannerManager()
    
    @Published public var data: BannerData?
    @Published public var isVisible: Bool = false
    
    private var queue: [BannerData] = []
    private var isShowing: Bool = false
    
    private init() {}
    
    public func showBanner(having data: BannerData) {
        queue.append(data)
        displayNext()
    }
    
    private func displayNext() {
        guard !isShowing, let next = queue.first else { return }
        isShowing = true
        self.data = next
        withAnimation { isVisible = true }
        
        Task {
            try? await Task.sleep(nanoseconds: UInt64(next.duration * 1_000_000_000))
            hideCurrent()
        }
    }
    
    public func hideCurrent() {
        withAnimation { isVisible = false }
        
        Task {
            try? await Task.sleep(nanoseconds: 400_000_000) // match animation
            if !queue.isEmpty { queue.removeFirst() }
            isShowing = false
            displayNext()
        }
    }
}

// MARK: - BannerView
public struct BannerView: ComponentViewProtocol {
    @ObservedObject var manager = BannerManager.shared
    
    public init() {}
    
    public var body: some View {
        if manager.isVisible, let data = manager.data {
            VStack {
                if data.position == .top { bannerContent }
                Spacer()
                if data.position == .bottom { bannerContent }
            }
            .padding(.horizontal)
            .transition(.move(edge: data.position == .top ? .top : .bottom).combined(with: .opacity))
            .animation(.easeInOut, value: manager.isVisible)
        }
    }
    
    private var bannerContent: some View {
        HStack(alignment: .top, spacing: ComponentTheme.Spacing.medium) {
            manager.data?.type.icon
                .font(ComponentTheme.Fonts.Size.large)
                .foregroundColor(.white)
            
            VStack(alignment: .leading, spacing: ComponentTheme.Spacing.xSmall) {
                if let title = manager.data?.title {
                    Text(title)
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.white)
                }
                if let subtitle = manager.data?.subtitle {
                    Text(subtitle)
                        .font(ComponentTheme.Fonts.Size.small)
                        .foregroundColor(.white)
                }
            }
            
            Spacer()
        }
        .padding()
        .background(manager.data?.type.backgroundColor ?? .blue)
        .cornerRadius(ComponentTheme.Radius.medium)
        .shadow(radius: ComponentTheme.Radius.xSmall)
        .onTapGesture {
            manager.hideCurrent()
        }
        .gesture(
            DragGesture(minimumDistance: 30)
                .onEnded { value in
                    let isVertical = abs(value.translation.height) > abs(value.translation.width)
                    let swipedUp = value.translation.height < 0
                    
                    if isVertical {
                        if (manager.data?.position == .top && swipedUp) ||
                            (manager.data?.position == .bottom && !swipedUp) {
                            manager.hideCurrent()
                        }
                    }
                }
        )
    }
}
