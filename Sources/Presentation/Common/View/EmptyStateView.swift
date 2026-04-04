//
//  EmptyStateView.swift
//  CulinarApp
//
//  Created by Варя Черепенникова on 01.04.2026.
//

import SwiftUI

struct EmptyStateView: View
{
    @State private var isAnimating = false
    @State private var appeared = false

    var body: some View {
        VStack(spacing: 16) {
            ZStack {
                Circle()
                    .fill(Color(.systemGray5))
                    .frame(width: 88, height: 88)

                Image(systemName: "fork.knife")
                    .font(.system(size: 36, weight: .medium))
                    .foregroundStyle(Color(.systemGray2))
                    .scaleEffect(isAnimating ? 1.08 : 1.0)
                    .animation(
                        .easeInOut(duration: 1.6)
                        .repeatForever(autoreverses: true),
                        value: isAnimating
                    )
            }
            .scaleEffect(appeared ? 1.0 : 0.6)
            .opacity(appeared ? 1.0 : 0)
            .animation(.spring(response: 0.4, dampingFraction: 0.6), value: appeared)

            VStack(spacing: 6) {
                Text("empty_search".localized())
                    .font(.system(size: 18, weight: .semibold, design: .rounded))
                    .foregroundStyle(.primary)

                Text("change_request".localized())
                    .font(.system(size: 14, weight: .regular, design: .rounded))
                    .foregroundStyle(.secondary)
            }
            .opacity(appeared ? 1.0 : 0)
            .offset(y: appeared ? 0 : 8)
            .animation(.easeOut(duration: 0.35).delay(0.15), value: appeared)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .onAppear {
            appeared = true
            isAnimating = true
        }
    }
}

#Preview {
    EmptyStateView()
}
