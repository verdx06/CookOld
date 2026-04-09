//
//  Animation.swift
//  CulinarApp
//
//  Created by Варя Черепенникова on 09.04.2026.
//

import SwiftUI
import Lottie

struct AnimationView: View {
    var onFinish: () -> Void

    var body: some View {
        LottieView(animation: .named("CookoldAnimation"))
            .playing(loopMode: .playOnce)
            .animationDidFinish { _ in onFinish() }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(.systemBackground))
            .ignoresSafeArea()
    }
}

#Preview {
    AnimationView(onFinish: {})
}
