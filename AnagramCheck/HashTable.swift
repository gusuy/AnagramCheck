//
//  HashTable.swift
//  AnagramCheck
//
//  Created by Gus Uy on 12/16/15.
//  Copyright © 2015 Gus Uy. All rights reserved.
//

import Foundation

class HashTable {
    
    struct Constants {
        // Number of words in txt file = 172820
        static let tableSize = 224669               // Prime number close to (num words in txt file * 1.3)
        static let filePath = NSBundle.mainBundle().pathForResource("words", ofType: "txt")
    }
    
    var buckets: [HashNode?]
    var collisions: Int
    
    
    init() {
        buckets = [HashNode?](count: Constants.tableSize, repeatedValue: nil)
        collisions = Int()
    }
    
    
    
    private func hashFunction(word: String) -> Int {
        var hash = 7
        
        // 71,387 collisions, 16-17s
        for var i = 0; i < word.characters.count; i++ {
            hash = hash*3 + Int(word.unicodeScalars[word.unicodeScalars.startIndex.advancedBy(i)].value)
            
        }
        
        hash = hash % Constants.tableSize
        //print(hash)
        
        return hash
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
            print("repeated")
            if node!.word == word {
                return true
            }
            node = node!.nextNode
        }
        
        return false
    }
    
}