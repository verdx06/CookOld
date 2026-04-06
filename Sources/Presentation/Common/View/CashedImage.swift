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
    @Environment(\.imageLoader) private var imageLoader

    var body: some View {
        ZStack {
            if let image {
                Image(uiImage: image)
                    .resizable()
            } else {
                PreviewRectangle()
            }
        }
        .task {
            guard let url else { return }
            self.image = await imageLoader.loadImage(url: url)
        }
    }
}
