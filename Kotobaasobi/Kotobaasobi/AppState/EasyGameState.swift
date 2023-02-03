//
//  EasyGameState.swift
//  Kotobaasobi
//
//  Created by Yoonjae on 2023/01/25.
//

import ComposableArchitecture
import SwiftUI

struct EasyGameState: Equatable {
    enum EasyGameState: Equatable {
        case playing
        case gameOver(didWin: Bool)
    }
    
    @BindableState var gameLanguage: GameLanguage = .EasyGameJapanese
    
    var word: String = Words.randomWord(in: .EasyGameJapanese)
    var currentGuess: String = ""
    var guesses: [String] = []
    var gameState: EasyGameState = .playing
    
    mutating func reset() {
        gameState = .playing
        word = Words.randomWord(in: gameLanguage)
        guesses.removeAll()
        print(word)
    }
    
    mutating func clear() {
        gameState = .playing
        guesses.removeAll()
    }
    
    init() {
        reset()
    }
    
}

enum EasyGameAction: BindableAction {
    case keyboardInput(KeyboardKey)
    case newGame
    case failGame
    case switchLanguage(GameLanguage)
    case binding(BindingAction<EasyGameState>)
}

struct EasyGameEnv {}

let EasyGameReducer = AnyReducer<EasyGameState, EasyGameAction, EasyGameEnv> { state, action, env in
    
    switch action {
    case let .keyboardInput(.character(char, _)):
        guard state.gameState == .playing else { return .none }
        if state.currentGuess.count < 3 {
            state.currentGuess += String(char).lowercased()
        }
        return .none
        
    case .keyboardInput(.symbol("delete.left")):
        guard state.gameState == .playing else { return .none }
        _ = state.currentGuess.popLast()
        return .none
        
    case .keyboardInput(.symbol("return.left")):
        guard state.currentGuess.count == 3 else { return .none }
        guard Words.contains(state.currentGuess, in: state.gameLanguage) else { return .none }
        state.guesses.append(state.currentGuess)
        
        if state.currentGuess == state.word {
            state.gameState = .gameOver(didWin: true)
        } else if state.guesses.count > 4 {
            state.gameState = .gameOver(didWin: false)
        }
        
        state.currentGuess = ""
        return .none
        
    case .newGame:
        state.reset()
        return .none
        
    case .failGame:
        state.clear()
        return .none
        
    case .keyboardInput(_):
        return .none
        
    case .switchLanguage(let language):
        guard language != state.gameLanguage else { return .none}
        state.gameLanguage = language
        state.reset()
        return .none
        
    case .binding:
        return .none
    }
}
    .binding()

extension EasyGameState {
    var boxes: [[LetterBox]] {
        var result = guesses.map { str -> [LetterBox] in
            var consumedWord = word
            return zip(str, self.word).map { s1, s2 -> LetterBox in
                if s1 == s2 {
                    return .character(s1, color: .green)
                }
                
                if let firstIndex = consumedWord.firstIndex(of: s1) {
                    consumedWord.remove(at: firstIndex)
                    return .character(s1, color: .yellow)
                }
                
                return .character(s1, color: .gray)
            }
        }
        
        if currentGuess.count > 0 {
            let current = currentGuess.map { LetterBox.character($0, color: .white) }
            + Array(repeating: .empty, count: 3 - currentGuess.count)
            result.append(current)
        }
        
        return result + Array(repeating: Array(repeating: LetterBox.empty, count: 3), count: 5 - result.count)
    }
    
    var keyboardKeys: [[KeyboardKey]] {
        let highlightedCharacters: Set<Character> = Set(guesses.joined()).intersection(word)
        let dimmedCharacters: Set<Character> = Set(guesses.joined())
        
        let keys = gameLanguage.keyboardLayout
        
        return keys.map {
            $0.map { key -> KeyboardKey in
                switch key {
                case let .character(char, _) where highlightedCharacters.contains(char):
                    return .character(char, .green)
                case let .character(char, _) where dimmedCharacters.contains(char):
                    return .character(char, .gray)
                default:
                    return key
                }
            }
        }
    }
}
