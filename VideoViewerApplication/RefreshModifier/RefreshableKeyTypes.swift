//
//  RefreshableKeyTypes.swift
//  VideoViewerApplication
//
//  Created by liga.griezne on 29/04/2024.
//

import SwiftUI

struct RefreshableKeyTypes {
    struct PrefKey: PreferenceKey {
        static var defaultValue: [CGFloat] = []
        static func reduce(value: inout [CGFloat], nextValue: () -> [CGFloat]) {
            value.append(contentsOf: nextValue())
        }
    }
}
