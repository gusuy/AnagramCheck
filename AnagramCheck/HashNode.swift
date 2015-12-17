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
    var nextNode: HashNode?
    
    
    init(word: String) {
        self.word = word
        nextNode = nil
    }

}