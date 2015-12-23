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
    
    
    
    // Permute all possible letter orders of word using recursion and add valid words to anagram array
    func evaluateWord (s1: String, s2: String) {
        let stringSize = s2.characters.count
        if stringSize < 1 {
            if hashTable.checkWord(s1) {
                if !anagrams.contains(s1) {
                    // If it's the original word, don't include in list of anagrams
                    if word == s1 {
                        isWord = true
                    }
                    else {
                        anagrams.append(s1)
                    }
                }
            }
        }
        else {
            for var i = 0; i < stringSize; i++ {
                evaluateWord(s1 + String(s2[s2.startIndex.advancedBy(i)]), s2: s2.substringToIndex(s2.startIndex.advancedBy(i)) + s2.substringFromIndex(s2.startIndex.advancedBy(i+1)))
            }
        }
    }
    
    
    // Read words from txt file and add to hash table
    func readFile() {
        if let streamReader = StreamReader(path: Constants.filePath!) {
            defer { streamReader.close() }
            while let line = streamReader.nextLine() {
                hashTable.addToTable(line)
            }
        }
        else {
            print("File read error")
        }
    }
    
    
  }