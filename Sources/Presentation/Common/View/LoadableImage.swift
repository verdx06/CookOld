//
//  CachedImage.swift
//  CulinarApp
//
//  Created by Варя Черепенникова on 04.04.2026.
//

import SwiftUI

struct LoadableImage: View
{
    let url: URL
    @State private var state: LoadingState = .idle
    @Environment(\.imageLoader) private var imageLoader

    var body: some View {
        ZStack {
            switch state {
            case .idle, .loading:
                PreviewRectangle()
            case .loaded(let image):
                Image(uiImage: image)
                    .resizable()
            case .failed:
                Image(systemName: "photo")
                    .foregroundStyle(.secondary)
            }
        }
        .task {
            guard case .idle = state else { return }
            state = .loading
            let image = await imageLoader.loadImage(url: url)
            guard Task.isCancelled == false else {
                state = .idle
                return
            }
            state = image.map { .loaded($0) } ?? .failed
        }
    }
}

private extension LoadableImage
{
    enum LoadingState
    {
        case idle
        case loading
        case loaded(UIImage)
        case failed
    }
}
