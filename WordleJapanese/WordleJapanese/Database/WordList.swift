//
//  WordList.swift
//  WordleJapanese
//
//  Created by Yoonjae on 2022/08/31.
//

import Foundation
import RealmSwift

class WordList: Object {
    @Persisted var easyWord: String?
    @Persisted var intermediateWord: String?
    @Persisted var hardWord: String?
    
    @Persisted(primaryKey: true) var _pk: ObjectId
    
    convenience init(easyWord: String, intermediateWord: String, hardWord: String) {
        self.init()
        self.easyWord = easyWord
        self.intermediateWord = intermediateWord
        self.hardWord = hardWord
    }
}


let realm = try! Realm()
