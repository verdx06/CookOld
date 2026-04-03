//
//  ErrorStateView.swift
//  CulinarApp
//
//  Created by Варя Черепенникова on 01.04.2026.
//

import SwiftUI

struct ErrorStateView: View {
    @State private var isShaking = false
    @State private var appeared = false

    var body: some View {
        VStack(spacing: 16) {
            ZStack {
                Circle()
                    .fill(Color.red.opacity(0.1))
                    .frame(width: 88, height: 88)

                Image(systemName: "fork.knife")
                    .font(.system(size: 36, weight: .medium))
                    .foregroundStyle(.red.opacity(0.8))
                    .rotationEffect(.degrees(isShaking ? -12 : 0))
                    .animation(
                        .easeInOut(duration: 0.12)
                        .repeatCount(5, autoreverses: true)
                        .delay(0.2),
                        value: isShaking
                    )
            }
            .scaleEffect(appeared ? 1.0 : 0.6)
            .opacity(appeared ? 1.0 : 0)
            .animation(.spring(response: 0.4, dampingFraction: 0.6), value: appeared)

            VStack(spacing: 6) {
                Text("Что-то пошло не так")
                    .font(.system(size: 18, weight: .semibold, design: .rounded))
                    .foregroundStyle(.primary)

                Text("Не удалось загрузить данные")
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
            isShaking = true
        }
    }
}

#Preview {
    ErrorStateView()
}
