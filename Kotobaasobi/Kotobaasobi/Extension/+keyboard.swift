//
//  +keyboard.swift
//  Kotobaasobi
//
//  Created by Yoonjae on 2023/01/30.
//

import SwiftUI

extension KeyboardKey {
    var backgroundColor: Color {
        switch self {
        case .character(_, let keyColor):
            return keyColor.backgroundColor
        case .symbol:
            return KeyColor.normal.backgroundColor
        }
    }
}

extension KeyboardKey.KeyColor {
    var backgroundColor: Color {
        switch self {
        case .normal:
            return .white
        case .green:
            return .green
        case .gray:
            return Color(white: 0.5)
        }
    }
}
