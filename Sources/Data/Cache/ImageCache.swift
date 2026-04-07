//
//  ImageCache.swift
//  CulinarApp
//
//  Created by Варя Черепенникова on 04.04.2026.
//

import UIKit

protocol ImageCache
{
    func get(url: URL) -> UIImage?
    func set(image: UIImage, url: URL)
}

final class CombinedImageCache: ImageCache
{
    private let memoryCache: NSImageCache
    private let diskCache: FileImageCache

    init(memoryCache: NSImageCache, diskCache: FileImageCache) {
        self.memoryCache = memoryCache
        self.diskCache = diskCache
    }

    func get(url: URL) -> UIImage? {
        if let image = memoryCache.get(url: url) {
            return image
        }

        if let image = diskCache.get(url: url) {
            memoryCache.set(image: image, url: url)
            return image
        }

        return nil
    }

    func set(image: UIImage, url: URL) {
        memoryCache.set(image: image, url: url)
        diskCache.set(image: image, url: url)
    }
}
