//
//  CustomTabBar.swift
//  CulinarApp
//
//  Created by Виталий Багаутдинов on 01.04.2026.
//

import SwiftUI

enum CustomTab: String, CaseIterable {
    case home = "Главная"
    case favorite = "Избранное"
    case dish = "Собери блюдо"
    
    var symbol: String {
        switch self {
        case .home:
            "house.fill"
        case .favorite:
            "heart.fill"
        case .dish:
            "cooktop.fill"
        }
    }
    
    var index: Int {
        Self.allCases.firstIndex(of: self) ?? 0
    }
    
}

struct CustomTabBar<TabItemView: View>: UIViewRepresentable {
    
    var size: CGSize
    var activeTint: Color = .blue
    /// Background of the whole control (behind all segments).
    var backgroundTint: Color = .gray.opacity(0.08)
    var barTint: Color = .gray.opacity(0.15)
    var cornerRadius: CGFloat = 14
    
    let queue = DispatchQueue.main
    
    @Binding var activeTab: CustomTab
    @ViewBuilder var tabItemView: (CustomTab) -> TabItemView
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    func makeUIView(context: Context) -> UISegmentedControl {
        let items = CustomTab.allCases.map(\.rawValue)
        let control = UISegmentedControl(items: items)
        control.selectedSegmentIndex = 0
        
        for (index, tab) in CustomTab.allCases.enumerated() {
            let render = ImageRenderer(content: tabItemView(tab))
            render.scale = 2
            
            let image = render.uiImage
            control.setImage(image, forSegmentAt: index)
        }
        
        queue.async {
            for subview in control.subviews {
                if subview is UIImageView && subview != control.subviews.last {
                    subview.alpha = 0
                }
            }
        }
        
        control.backgroundColor = UIColor(backgroundTint)
        control.layer.cornerRadius = cornerRadius
        control.layer.masksToBounds = true
        
        control.selectedSegmentTintColor = UIColor(barTint)
        control.setTitleTextAttributes([
            .foregroundColor: UIColor(activeTint)
        ], for: .selected)
        
        control.addTarget(context.coordinator, action: #selector(context.coordinator.tabSelected(_:)), for: .valueChanged)
        return control
    }
    
    func updateUIView(_ uiView: UISegmentedControl, context: Context) {
        //
    }
    
    func sizeThatFits(_ proposal: ProposedViewSize, uiView: UISegmentedControl, context: Context) -> CGSize? {
        return size
    }
    
    class Coordinator: NSObject {
        var parent: CustomTabBar
        init(parent: CustomTabBar) {
            self.parent = parent
        }
        
        @objc func tabSelected(_ control: UISegmentedControl) {
            parent.activeTab = CustomTab.allCases[control.selectedSegmentIndex]
        }
        
    }
}
