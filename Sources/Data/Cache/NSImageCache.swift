//
//  NSImageCache.swift
//  CulinarApp
//
//  Created by Варя Черепенникова on 06.04.2026.
//

import UIKit

final class NSImageCache: ImageCache
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
}
