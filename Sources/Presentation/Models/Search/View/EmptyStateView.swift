//
//  EmptyStateView.swift
//  CulinarApp
//
//  Created by Варя Черепенникова on 01.04.2026.
//

import SwiftUI

struct EmptyStateView: View {
    var body: some View {
        VStack {
            Image(systemName: "fork.knife")
            Text("Ничего не найдено")
        }
    }
}
