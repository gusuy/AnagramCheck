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
    func addToTable(key: String, value: String) {
        let thisNode = HashNode(word: value, sortedWord: key)
        let hashValue = hashFunction(key)
        let destNode = buckets[hashValue]
        
        if destNode != nil {
            collisions++
            thisNode.nextNode = destNode
        }
        
        buckets[hashValue] = thisNode
    }
    
    
    // Returns an array with all anagrams of the passed value and true if the value is a word
    func getAnagrams(key: String, value: String) -> (anagrams: [String], isWord: Bool) {
        let hashValue = hashFunction(key)
        var node = buckets[hashValue]
        var anagramArray = [String]()
        var isWord = false
        
        if node == nil {
            return (anagramArray, isWord)
        }
        
        while node != nil {
            if node!.sortedWord == key {
                if node!.word != value {
                    isWord = true
                }
                else {
                    anagramArray.append(node!.word)
                }
            }
            node = node!.nextNode
        }
        
        return (anagramArray, isWord)
    }
    
    
    // Compute hash value using djb2 hash algorithm
    private func hashFunction(key: String) -> Int {
        var hash:UInt = 5381
        
        for char in key.unicodeScalars {
            hash = ((hash << 5) &+ hash) &+ UInt(char.value)
        }
        
        hash = hash % UInt(tableSize)
        
        return Int(hash)
    }
    
    
}