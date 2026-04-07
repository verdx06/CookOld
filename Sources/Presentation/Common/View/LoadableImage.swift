//
//  CachedImage.swift
//  CulinarApp
//
//  Created by Варя Черепенникова on 04.04.2026.
//

import SwiftUI

struct LoadableImage: View
{
    let url: URL?
    @State private var state: LoadingState = .loading
    @Environment(\.imageLoader) private var imageLoader

    var body: some View {
        ZStack {
            switch state {
            case .loading:
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
            guard let url else {
                state = .failed
                return
            }
            if let image = await imageLoader.loadImage(url: url) {
                state = .loaded(image)
            } else {
                state = .failed
            }
        }
    }
}

private extension LoadableImage
{
    enum LoadingState
    {
        case loading
        case loaded(UIImage)
        case failed
    }
}
