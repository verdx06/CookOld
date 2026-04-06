//
//  ImageLoader.swift
//  CulinarApp
//
//  Created by Варя Черепенникова on 06.04.2026.
//

import UIKit
import SwiftUI

protocol ImageLoader
{
    func loadImage(url: URL) async -> UIImage?
}

final class ImageLoaderImpl: ImageLoader
{
    private let cache: ImageCache

    init(cache: ImageCache) {
        self.cache = cache
    }

    func loadImage(url: URL) async -> UIImage? {
        if let cached = cache.get(url: url) {
            return cached
        }

        guard let (data, _) = try? await URLSession.shared.data(from: url),
              let downloaded = UIImage(data: data) else { return nil }

        cache.set(image: downloaded, url: url)
        return downloaded
    }
}

private struct ImageLoaderKey: EnvironmentKey
{
    static let defaultValue: ImageLoader = ImageLoaderImpl(
        cache: ImageCacheImpl(
            memoryCache: NSImageCache(),
            diskCache: FileImageCache()
        )
    )
}

extension EnvironmentValues
{
    var imageLoader: ImageLoader {
        get { self[ImageLoaderKey.self] }
        set { self[ImageLoaderKey.self] = newValue }
    }
}
