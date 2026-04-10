//
//  LHCButtonView.swift
//  CulinarApp
//
//  Created by eventya on 08.04.2026.
//
import SwiftUI

struct LetHimCookButton: View {
    @State private var dragX: CGFloat = 0
    @State private var dragY: CGFloat = 0
    @State private var isDragging: Bool = false
    var action: () -> Void

    // Cap the drag vector by magnitude (circle), then project back to x/y
    private var capped: (x: CGFloat, y: CGFloat) {
        let mag = sqrt(dragX * dragX + dragY * dragY)
        let cap: CGFloat = 30
        guard mag > cap else { return (dragX, dragY) }
        let ratio = cap / mag
        return (dragX * ratio, dragY * ratio)
    }

    private var xScale: CGFloat { 1 + abs(capped.x) / 400 }
    private var yScale: CGFloat { 1 + abs(capped.y) / 400 }

    // Anchor is the opposite corner of the drag direction so the shape extends toward the finger
    private var dragAnchor: UnitPoint {
        let axc: CGFloat = dragX > 3 ? 0 : (
            dragX < -3 ? 1 : 0.5
        )
        let ayc: CGFloat = dragY > 3 ? 0 : (
            dragY < -3 ? 1 : 0.5
        )
        return UnitPoint(x: axc, y: ayc)
    }

    var body: some View {
        Button {
            action()
        } label: {
            Text("LET\nHIM\nCOOK")
                .font(.system(size: 18, weight: .bold))
                .multilineTextAlignment(.center)
                .frame(width: 100, height: 100)
        }
        .buttonStyle(LetHimCookButtonStyle(isDragging: isDragging))
        .scaleEffect(x: xScale, y: yScale, anchor: dragAnchor)
        .animation(.interactiveSpring(response: 0.3, dampingFraction: 0.8), value: dragX)
        .animation(.interactiveSpring(response: 0.3, dampingFraction: 0.8), value: dragY)
        .simultaneousGesture(
            DragGesture(minimumDistance: 3)
                .onChanged {
                    isDragging = true
                    dragX = $0.translation.width
                    dragY = $0.translation.height
                }
                .onEnded { _ in
                    withAnimation(.spring(response: 0.4, dampingFraction: 0.65)) {
                        isDragging = false
                        dragX = 0
                        dragY = 0
                    }
                }
        )
    }
}

private struct LetHimCookButtonStyle: ButtonStyle {
    let isDragging: Bool

    func makeBody(configuration: Configuration) -> some View {
        ZStack {
            if #available(iOS 26, *) {
                Color.clear
                    .frame(width: 100, height: 100)
                    .glassEffect(in: Circle())
            } else {
                Color(.systemGray)
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())
            }
            configuration.label
                .foregroundColor(configuration.isPressed || isDragging ? Color.accentColor : .black)
        }
        .scaleEffect(configuration.isPressed || isDragging ? 1.05 : 1.0)
        .animation(.spring(duration: 0.3, bounce: 0.2), value: configuration.isPressed)
    }
}
