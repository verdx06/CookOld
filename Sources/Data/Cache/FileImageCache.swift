//
//  FileImageCache.swift
//  CulinarApp
//
//  Created by Варя Черепенникова on 06.04.2026.
//

import UIKit

final class FileImageCache: ImageCache
{
    func get(url: URL) -> UIImage? {
        guard let cacheDirectory else { return nil }
        let fileURL = cacheDirectory.appendingPathComponent(fileName(for: url))
        guard let data = try? Data(contentsOf: fileURL) else { return nil }
        return UIImage(data: data)
    }

    func set(image: UIImage, url: URL) {
        guard let cacheDirectory,
              let data = image.jpegData(compressionQuality: 0.8) else { return }
        try? FileManager.default.createDirectory(at: cacheDirectory, withIntermediateDirectories: true)
        let fileURL = cacheDirectory.appendingPathComponent(fileName(for: url))
        try? data.write(to: fileURL)
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
