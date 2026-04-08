//
//  ErrorStateView.swift
//  CulinarApp
//
//  Created by Варя Черепенникова on 01.04.2026.
//

import SwiftUI

struct ErrorStateView: View
{
    /// Если задано, показывается вместо стандартного подзаголовка (например, текст из `HomeViewModel`).
    var detailMessage: String?
    var onRetry: (() -> Void)?
    @Environment(\.disableEntryAnimation) private var disableEntryAnimation
    @State private var appeared = false

    private var isAppeared: Bool { disableEntryAnimation || appeared }

    init(detailMessage: String? = nil, onRetry: (() -> Void)? = nil) {
        self.detailMessage = detailMessage
        self.onRetry = onRetry
    }

    var body: some View {
        VStack(spacing: 16) {
            ZStack {
                Circle()
                    .fill(Color.red.opacity(0.1))
                    .frame(width: 88, height: 88)

                Image(systemName: "fork.knife")
                    .font(.system(size: 36, weight: .medium))
                    .foregroundStyle(.red.opacity(0.8))
            }
            .scaleEffect(isAppeared ? 1.0 : 0.6)
            .opacity(isAppeared ? 1.0 : 0)
            .animation(.spring(response: 0.4, dampingFraction: 0.6), value: appeared)

            VStack(spacing: 6) {
                Text("search_error".localized())
                    .font(.system(size: 18, weight: .semibold, design: .rounded))
                    .foregroundStyle(.primary)

                Text(self.subtitleText)
                    .font(.system(size: 14, weight: .regular, design: .rounded))
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
            }
            .opacity(isAppeared ? 1.0 : 0)
            .offset(y: isAppeared ? 0 : 8)
            .animation(.easeOut(duration: 0.35).delay(0.15), value: appeared)

            if let onRetry = self.onRetry {
                Button("retry".localized(), action: onRetry)
                    .buttonStyle(.borderedProminent)
                    .opacity(isAppeared ? 1.0 : 0)
                    .animation(.easeOut(duration: 0.35).delay(0.25), value: appeared)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .onAppear {
            appeared = true
        }
    }

    private var subtitleText: String {
        if let detail = self.detailMessage, detail.isEmpty == false {
            return detail
        }
        return "data_loading_failed".localized()
    }
}

#Preview {
    ErrorStateView()
}
