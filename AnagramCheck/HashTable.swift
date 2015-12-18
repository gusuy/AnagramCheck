//
//  HashTable.swift
//  AnagramCheck
//
//  Created by Gus Uy on 12/16/15.
//  Copyright © 2015 Gus Uy. All rights reserved.
//

import Foundation

class HashTable {
    // TODO: Reduce number of collisions
    
    struct Constants {
        // Number of words in txt file = 172820
        static let tableSize = 345643
        static let filePath = NSBundle.mainBundle().pathForResource("words", ofType: "txt")
    }
    
    private var buckets: [HashNode?]                    // Hash table structured with array of linked lists
    var collisions: Int
    
    
    init() {
        buckets = [HashNode?](count: Constants.tableSize, repeatedValue: nil)
        collisions = Int()
    }
    
    
    
    // Read words from txt file and call addToTable for each
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
    
    
    // Add node to bucket array using hash value as index
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
    
    
    // Compute hash value using djb2 hash algorithm
    private func hashFunction(word: String) -> Int {
        var hash:UInt = 5381
        
        for var i = 0; i < word.characters.count; i++ {
            hash = ((hash << 5) &+ hash) &+ UInt(word.unicodeScalars[word.unicodeScalars.startIndex.advancedBy(i)].value)
        }
        
        hash = hash % UInt(Constants.tableSize)
        
        return Int(hash)
    }
    
    
    // Return true if the passed string is in the hash table
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