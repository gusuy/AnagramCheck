//
//  HashTable.swift
//  AnagramCheck
//
//  Created by Gus Uy on 12/16/15.
//  Copyright © 2015 Gus Uy. All rights reserved.
//

import Foundation

class HashTable {
    // TODO: Improve hash function
    
    struct Constants {
        // Number of words in txt file = 172820
        static let tableSize = 345643
        static let filePath = NSBundle.mainBundle().pathForResource("words", ofType: "txt")
    }
    
    var buckets: [HashNode?]
    var collisions: Int
    
    
    init() {
        buckets = [HashNode?](count: Constants.tableSize, repeatedValue: nil)
        collisions = Int()
    }
    
    
    // Using djb2 hash algorithm
    private func hashFunction(word: String) -> Int {
        var hash:UInt = 5381
        
        for var i = 0; i < word.characters.count; i++ {
            hash = ((hash << 5) &+ hash) &+ UInt(word.unicodeScalars[word.unicodeScalars.startIndex.advancedBy(i)].value)
        }
        
        hash = hash % UInt(Constants.tableSize)
        
        return Int(hash)
    }
    
    
    func readFile() {
        if let streamReader = StreamReader(path: Constants.filePath!) {
            defer { streamReader.close() }
            while let line = streamReader.nextLine() {
                addToTable(line)
            }
        }
        else {
            print("File read error")
        }
    }
    
    
    private func addToTable(word: String) {
        let thisNode = HashNode(word: word)
        let hashValue = hashFunction(word)
        let destNode = buckets[hashValue]
        
        if destNode != nil {
            collisions++
            thisNode.nextNode = destNode
        }
        
        buckets[hashValue] = thisNode
    }
    
    
    func checkWord(word: String) -> Bool {
        let hashValue = hashFunction(word)
        var node = buckets[hashValue]
        
        if node == nil {
            return false
        }
        
        while node != nil {
            if node!.word == word {
                return true
            }
            node = node!.nextNode
        }
        
        return false
    }
    
}