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
        return UIImage(systemName: "photo")
    }
}
