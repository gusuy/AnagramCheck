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
    // Could use NSHashTable, but implementing own hash table allows for testing and comparing different hash functions
    
    fileprivate var buckets: [HashNode?]                    // Hash table structured with array of linked lists
    fileprivate var collisions: Int
    fileprivate var tableSize: Int
    
    
    init(tableSize: Int) {
        buckets = [HashNode?](repeating: nil, count: tableSize)
        collisions = Int()
        self.tableSize = tableSize
    }
    
    
    func getCollisions() -> Int {
        return collisions
    }
    
    
    
    // Add node to bucket array using hash value as index
    func addToTable(_ key: String, value: String) {
        let thisNode = HashNode(word: value, sortedWord: key)
        let hashValue = hashFunction(key)
        let destNode = buckets[hashValue]
        
        if destNode != nil {
            collisions += 1
            thisNode.nextNode = destNode
        }
        
        buckets[hashValue] = thisNode
    }
    
    
    // Takes a key and returns all corresponding values
    func getValuesWithKey(_ key: String) -> [String] {
        let hashValue = hashFunction(key)
        var node = buckets[hashValue]
        var values = [String]()
        
        // No matches
        if node == nil {
            return values
        }
        
        // Iterate through linked list and retrieve values where keys match
        while node != nil {
            if node!.key == key {
                values.append(node!.word)
            }
            node = node!.nextNode
        }
        
        return values
    }
    
    
    // Compute hash value using djb2 hash algorithm
    fileprivate func hashFunction(_ key: String) -> Int {
        var hash:UInt = 5381
        
        for char in key.unicodeScalars {
            hash = ((hash << 5) &+ hash) &+ UInt(char.value)
        }
        
        hash = hash % UInt(tableSize)
        
        return Int(hash)
    }
    
    
}
