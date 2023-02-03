//
//  Models.swift
//  Kotobaasobi
//
//  Created by Yoonjae on 2023/01/10.
//

import SwiftUI
import ComposableArchitecture

enum GameLanguage: CaseIterable {
    case english
    case EasyGameJapanese
    case NormalGameJapanese
    case HardGameJapanese
    
    var description: String {
        switch self {
        case .english:
            return "English"
        case .EasyGameJapanese:
            return "EasyGameJapanese"
        case .NormalGameJapanese:
            return "NormalGameJapanese"
        case .HardGameJapanese:
            return "HardGameJapanese"
        }
    }
    
    var answersFileName: String {
        switch self {
        case .english:
            return "wordle-answers-alphabetical_en"
        case .EasyGameJapanese:
            return "EasyGameAnswerJapaneseWord"
        case .NormalGameJapanese:
            return "NormalGameAnswerJapaneseWord"
        case .HardGameJapanese:
            return "HardGameAnswerJapaneseWord"
        }
    }
    
    var allowedGuessesFileName: String {
        switch self {
        case .english:
            return "wordle-allowed-guesses_en"
        case .EasyGameJapanese:
            return "EasyGameGuessJapaneseWord"
        case .NormalGameJapanese:
            return "NormalGameGuessJapaneseWord"
        case .HardGameJapanese:
            return "HardGameGuessJapaneseWord"
        }
    }
    
    var keyboardLayout: [[KeyboardKey]] {
        switch self {
        case .english:
            return [
                ["q", "w", "e", "r", "t", "y", "u", "i", "o", "p"],
                ["a", "s", "d", "f", "g", "h", "j", "k", "l"],
                [.symbol("return.left"), "z", "x", "c", "v", "b", "n", "m", .symbol("delete.left")],
            ]
        case .EasyGameJapanese:
            return [
                ["あ", "い", "う", "え", "お", "か", "き", "く", "け", "こ"],
                ["さ", "し", "す", "せ", "そ", "た", "ち", "つ", "て", "と"],
                ["な", "に", "ぬ", "ね","の", "は", "ひ", "ふ", "へ", "ほ"],
                ["ま", "み", "む", "め", "も", "ら", "り", "る", "れ", "ろ"],
                [.symbol("return.left"), "や", "ゆ", "よ", "わ", "を", "ん", .symbol("delete.left")],
            ]
        case .NormalGameJapanese:
            return [
                ["あ", "い", "う", "え", "お", "か", "き", "く", "け", "こ"],
                ["さ", "し", "す", "せ", "そ", "た", "ち", "つ", "て", "と"],
                ["な", "に", "ぬ", "ね","の", "は", "ひ", "ふ", "へ", "ほ"],
                ["ま", "み", "む", "め", "も", "ら", "り", "る", "れ", "ろ"],
                [.symbol("return.left"), "や", "ゆ", "よ", "わ", "を", "ん", .symbol("delete.left")],
            ]
        case .HardGameJapanese:
            return [
                ["あ", "い", "う", "え", "お", "か", "き", "く", "け", "こ"],
                ["さ", "し", "す", "せ", "そ", "た", "ち", "つ", "て", "と"],
                ["な", "に", "ぬ", "ね","の", "は", "ひ", "ふ", "へ", "ほ"],
                ["ま", "み", "む", "め", "も", "ら", "り", "る", "れ", "ろ"],
                [.symbol("return.left"), "や", "ゆ", "よ", "わ", "を", "ん", .symbol("delete.left")],
            ]
        }
    }
}


enum LetterBox: Equatable {
    enum LetterBoxColor: Equatable {
        case black
        case gray
        case yellow
        case green
        case white
        
        var backgroundColor: Color {
            switch self {
            case .black:
                return .black
            case .yellow:
                return .yellow
            case .green:
                return .green
            case .gray:
                return .gray
            case .white:
                return .white
            }
        }
    }
    
    case character(Character, color: LetterBoxColor)
    case empty
}

public enum KeyboardKey: Equatable, ExpressibleByExtendedGraphemeClusterLiteral {
    public typealias ExtendedGraphemeClusterLiteralType = Character
    
    public enum KeyColor: Equatable {
        case normal
        case green
        case gray
    }
    
    case character(Character, KeyColor)
    case symbol(String)
    
    public init(extendedGraphemeClusterLiteral value: Character) {
        self = .character(value, .normal)
    }
}

