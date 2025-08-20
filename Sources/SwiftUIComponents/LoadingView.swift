//
//  LoadingView.swift
//
//
//
//

import SwiftUI

struct LoadingView: View {
    var message: String? = nil
    
    var body: some View {
        ZStack {
            /// dimmed background
            Color.black.opacity(0.4)
                .ignoresSafeArea()
            
            /// spinner and message
            VStack(spacing: 16) {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                //                    .scaleEffect(1.5)
                
                if let message {
                    Text(message)
                        .foregroundColor(.white)
                        .font(.headline)
                }
            }
            .padding(32)
            .background(Color(.systemGray).opacity(0.8))
            .cornerRadius(16)
        }
        .transition(.opacity)
    }
}
