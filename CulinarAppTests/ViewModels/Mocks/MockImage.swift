//
//  MockImage.swift
//  CulinarApp
//
//  Created by Варя Черепенникова on 07.04.2026.
//

import UIKit
@testable import CulinarApp

final class MockImageLoader: ImageLoading {
    func loadImage(url: URL) async -> UIImage? {
        let size = CGSize(width: 100, height: 100)
        UIGraphicsBeginImageContextWithOptions(size, false, 1.0)
        UIColor.gray.setFill()
        UIRectFill(CGRect(origin: .zero, size: size))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}
