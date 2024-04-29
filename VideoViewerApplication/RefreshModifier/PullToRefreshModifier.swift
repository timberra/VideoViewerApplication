//
//  PullToRefreshModifier.swift
//  VideoViewerApplication
//
//  Created by liga.griezne on 29/04/2024.
//

import SwiftUI
struct PullToRefreshModifier: ViewModifier {
    @Binding var isRefreshing: Bool
    let action: () -> Void

    func body(content: Content) -> some View {
        content
            .overlay(
                GeometryReader { geo in
                    if self.isRefreshing {
                        ProgressView()
                            .offset(y: -geo.size.height / 2)
                    }
                }
            )
            .onPreferenceChange(RefreshableKeyTypes.PrefKey.self) { values in
                self.isRefreshing = false
            }
            .gesture(
                DragGesture(minimumDistance: 15, coordinateSpace: .local)
                    .onChanged { value in
                        if value.translation.height > 0 {
                            withAnimation {
                                self.isRefreshing = true
                            }
                        }
                    }
                    .onEnded { value in
                        if value.predictedEndLocation.y > 50 {
                            self.action()
                        }
                    }
            )
    }
}
