//
//  ImageCache.swift
//  CulinarApp
//
//  Created by Варя Черепенникова on 04.04.2026.
//

import Foundation
import UIKit

protocol ImageCache {
    func get(url: URL) -> UIImage?
    func set(image: UIImage, url: URL)
    func load(url: URL) async -> UIImage?
}

final class ImageCacheImpl : ImageCache {
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
        
        guard let (data, _) = try? await URLSession.shared.data(from: url),
              let image = UIImage(data: data) else {
            return nil
        }
        set(image: image, url: url)
        return image
    }
}
