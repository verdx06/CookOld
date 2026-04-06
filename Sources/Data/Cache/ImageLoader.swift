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
    private let session: URLSession

    init(cache: ImageCache, session: URLSession = .shared) {
        self.cache = cache
        self.session = session
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

private struct ImageLoaderKey: EnvironmentKey
{
    static let defaultValue: ImageLoader = ImageLoaderImpl(
        cache: CombinedImageCache(
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
