//
//  HashNode.swift
//  AnagramCheck
//
//  Created by Gus Uy on 12/16/15.
//  Copyright © 2015 Gus Uy. All rights reserved.
//

import Foundation

class HashNode {

    var word: String
    var sortedWord: String
    var nextNode: HashNode?
    
    
    init(word: String, sortedWord: String) {
        self.word = word
        self.sortedWord = sortedWord
        nextNode = nil
    }

}