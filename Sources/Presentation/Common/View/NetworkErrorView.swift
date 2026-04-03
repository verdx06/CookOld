//
//  NetworkErrorView.swift
//  CulinarApp
//

import SwiftUI

struct NetworkErrorView: View
{
    let message: String
    let onRetry: () -> Void

    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "wifi.exclamationmark")
                .font(.system(size: 48))
                .foregroundStyle(.secondary)

            Text("Нет интернета")
                .font(.title2.bold())

            Text(self.message)
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal)

            Button("Повторить", action: self.onRetry)
                .buttonStyle(.borderedProminent)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(24)
    }
}

#Preview {
    NetworkErrorView(message: "The Internet connection appears to be offline.") {}
}
