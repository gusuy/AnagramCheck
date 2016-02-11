//
//  AnagramCheck.swift
//  AnagramCheck
//
//  Created by Gus Uy on 11/25/15.
//  Copyright (c) 2015 Gus Uy. All rights reserved.
//

import Foundation

class AnagramCheck {
    
    struct Constants {
        // Number of words in txt file = 172820
        static let tableSize = 345643
        static let filePath = NSBundle.mainBundle().pathForResource("words", ofType: "txt")
    }
    
    var hashTable: HashTable
    var word: String                // Store user input
    var anagrams: [String]          // Hold the resulting anagrams if any
    var isWord:Bool                 // True if user input is a valid word
    
    
    init() {
        hashTable = HashTable(tableSize: Constants.tableSize)
        word = String()
        anagrams = [String]()
        isWord = false
    }
    
    
    
    // Fills the anagram array and sets isWord
    func setAnagrams() {
        anagrams.removeAll()
        isWord = false
        
        let values = hashTable.getValuesWithKey(sortString(word))
        for value: String in values {
            if value == word {
                isWord = true
            }
            else {
                anagrams.append(value)
            }
        }
    }
        
    
    // Read words from txt file and add to hash table
    // When adding words to hash table, passes sorted string as the key since all anagrams are the same string when sorted
    // Therefore, all anagrams have the same key and get placed in the same bucket of the hash table for fast retrieval
    func readFile() {
        if let streamReader = StreamReader(path: Constants.filePath!) {
            defer { streamReader.close() }
            while let line = streamReader.nextLine() {
                hashTable.addToTable(sortString(line), value: line)
            }
        }
        else {
            print("File read error")
        }
    }
    
    
    // Sorts a string alphabetically
    func sortString(word: String) -> String{
        let charArray = Array(word.characters)
        let sortedCharArray = charArray.sort( { $0 < $1 } )
        return String(sortedCharArray)
    }
    
  }