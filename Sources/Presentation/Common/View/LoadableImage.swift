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
                PreviewRectangle(cornerRadius: 0)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            case .loaded(let image):
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            case .failed:
                PreviewRectangle(cornerRadius: 0)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                Image(systemName: "photo")
                    .foregroundStyle(.secondary)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .clipped()
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
