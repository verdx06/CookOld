//
//  ImageLoader.swift
//  CulinarApp
//
//  Created by Варя Черепенникова on 06.04.2026.
//

import UIKit
import SwiftUI

final class ImageLoader
{
    private let cache: ImageCache
    private let session: URLSession

    init(cache: ImageCache, session: URLSession = .shared) {
        self.cache = cache
        self.session = session
    }

    func cachedImage(for url: URL) -> UIImage? {
        cache.get(url: url)
    }

    func loadImage(url: URL) async -> UIImage? {
        if let cached = cache.get(url: url) {
            return cached
        }

        let data: Data
        do {
            (data, _) = try await session.data(from: url)
        } catch {
            print("Ошибка загрузки изображения \(url): \(error)")
            return nil
        }

        guard let downloaded = UIImage(data: data) else {
            print("Ошибка декодирования изображения: \(url)")
            return nil
        }

        cache.set(image: downloaded, url: url)
        return downloaded
    }
}

extension EnvironmentValues
{
    @Entry var imageLoader = ImageLoader(
        cache: CombinedImageCache(
            memoryCache: NSImageCache(),
            diskCache: FileImageCache()
        ),
        session: URLSession.shared
    )
}
