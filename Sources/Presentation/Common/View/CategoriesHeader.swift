//
//  CategoriesHeader.swift
//  CulinarApp
//
//  Created by Варя Черепенникова on 03.04.2026.
//

import SwiftUI

struct CategoriesHeader: View
{
    var body: some View {
        Text("categories".localized())
            .font(.title.bold())
            .padding(.horizontal, 16)
            .padding(.top, 10)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}
