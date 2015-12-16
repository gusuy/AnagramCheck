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
    }
    
    var buckets = [HashNode?](count: Constants.tableSize, repeatedValue: nil)
    
    
    func hashFunction(word: String) -> Int {
        return 0
    }
    
    
    func loadTable() {
        var filePath = NSBundle.mainBundle().pathForResource("words", ofType: "txt")
        if let streamReader = StreamReader(path: filePath!) {
            defer { streamReader.close() }
            
            while let line = streamReader.nextLine() {
                // Run word through hash function, then add to table
                
            }
        } else {
            print("File read error")
        }
    }
    
    
}