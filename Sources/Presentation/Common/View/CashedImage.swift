//
//  CachedImage.swift
//  CulinarApp
//
//  Created by Варя Черепенникова on 04.04.2026.
//

import SwiftUI

struct CachedAsyncImage: View {
    let url: URL?
    let imageCache: ImageCache
    @State private var image: UIImage? = nil
    
    var body: some View {
        Group {
            if let image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
            } else {
                PreviewRectangle()
            }
        }
        .task {
            guard let url else { return }
            self.image = await imageCache.load(url: url)
        }
    }
}
