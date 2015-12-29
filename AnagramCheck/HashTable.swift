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
    // Could use NSHashTable, but implementing own hash table allows me to play around with and compare different hash functions
    
    private var buckets: [HashNode?]                    // Hash table structured with array of linked lists
    var collisions: Int
    private var tableSize: Int
    
    
    init(tableSize: Int) {
        buckets = [HashNode?](count: tableSize, repeatedValue: nil)
        collisions = Int()
        self.tableSize = tableSize
    }
    
    
    
    // Add node to bucket array using hash value as index
    func addToTable(word: String) {
        let thisNode = HashNode(word: word)
        let hashValue = hashFunction(word)
        let destNode = buckets[hashValue]
        
        if destNode != nil {
            collisions++
            thisNode.nextNode = destNode
        }
        
        buckets[hashValue] = thisNode
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
    
    
    // Compute hash value using djb2 hash algorithm
    private func hashFunction(word: String) -> Int {
        var hash:UInt = 5381
        
        for char in word.unicodeScalars {
            hash = ((hash << 5) &+ hash) &+ UInt(char.value)
        }
        
        hash = hash % UInt(tableSize)
        
        return Int(hash)
    }
    
    
}