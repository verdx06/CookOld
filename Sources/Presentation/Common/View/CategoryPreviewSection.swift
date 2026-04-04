//
//  CategoryPreviewSection.swift
//  CulinarApp
//
//  Created by Варя Черепенникова on 03.04.2026.
//

import SwiftUI

struct CategoryPreviewSection: View {
    var body: some View {
        ScrollView {
            CategoriesHeader()
            CategoryGridPreview()
        }
    }
}
