//
//  CachedImage.swift
//  CulinarApp
//
//  Created by Варя Черепенникова on 04.04.2026.
//

import SwiftUI

struct CachedImage: View
{
    let url: URL?
    @State private var image: UIImage?
    @State private var isLoading = true
    @Environment(\.imageLoader) private var imageLoader

    var body: some View {
        ZStack {
            if let image {
                Image(uiImage: image)
                    .resizable()
            } else if isLoading {
                PreviewRectangle()
            } else {
                Image(systemName: "photo")
                    .foregroundStyle(.secondary)
            }
        }
        .task {
            guard let url else {
                isLoading = false
                return
            }
            image = await imageLoader.loadImage(url: url)
            isLoading = false
        }
    }
}
