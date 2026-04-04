//
//  ImageCache.swift
//  CulinarApp
//
//  Created by Варя Черепенникова on 04.04.2026.
//

import Foundation
import UIKit

protocol ImageCache
{
    func get(url: URL) -> UIImage?
    func set(image: UIImage, url: URL)
    func load(url: URL) async -> UIImage?
    func loadFromDisc(url: URL) async -> UIImage?
    func saveToDisc(image: UIImage, url: URL)
}

final class ImageCacheImpl: ImageCache
{
    private let cache = NSCache<NSURL, UIImage>()

    init(countLimit: Int = 100, totalCostLimit: Int = 50 * 1024 * 1024) {
        cache.countLimit = countLimit
        cache.totalCostLimit = totalCostLimit
    }

    func get(url: URL) -> UIImage? {
        cache.object(forKey: url as NSURL)
    }

    func set(image: UIImage, url: URL) {
        cache.setObject(image, forKey: url as NSURL)
    }

    func load(url: URL) async -> UIImage? {
        if let cached = get(url: url) {
            return cached
        }

        if let diskImage = loadFromDisc(url: url) {
            set(image: diskImage, url: url)
            return diskImage
        }

        guard let (data, _) = try? await URLSession.shared.data(from: url),
              let image = UIImage(data: data) else {
            return nil
        }

        set(image: image, url: url)
        saveToDisc(image: image, url: url)
        return image
    }

    func saveToDisc(image: UIImage, url: URL) {
        guard let cacheDirectory,
              let data = image.jpegData(compressionQuality: 0.8) else { return }
        try? FileManager.default.createDirectory(at: cacheDirectory, withIntermediateDirectories: true)
        let fileURL = cacheDirectory.appendingPathComponent(fileName(for: url))
        try? data.write(to: fileURL)
    }

    func loadFromDisc(url: URL) -> UIImage? {
        guard let cacheDirectory else { return nil }
        let fileURL = cacheDirectory.appendingPathComponent(fileName(for: url))
        guard let data = try? Data(contentsOf: fileURL) else { return nil }
        return UIImage(data: data)
    }

    private func fileName(for url: URL) -> String {
        url.lastPathComponent
    }

    private var cacheDirectory: URL? {
        FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)
            .first?
            .appendingPathComponent("ImageCache")
    }
}
