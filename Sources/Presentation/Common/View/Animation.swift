//
//  Animation.swift
//  CulinarApp
//
//  Created by Варя Черепенникова on 09.04.2026.
//

import SwiftUI
import Lottie

struct AnimationView: View {
    var body: some View {
        LottieView(animation: .named("CookoldAnimation"))
            .playing(loopMode: .loop)
            .frame(width: 400, height: 400)
    }
}

#Preview {
    AnimationView()
}
