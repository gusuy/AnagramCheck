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
    
    private var hashTable: HashTable
    private var word: String                // Store user input
    private var anagrams: [String]          // Hold the resulting anagrams if any
    private var isWord:Bool                 // True if user input is a valid word
    
    
    init() {
        hashTable = HashTable(tableSize: Constants.tableSize)
        word = String()
        anagrams = [String]()
        isWord = false
    }
    
    
    func getAnagrams() -> [String] {
        return anagrams
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
    
    
    func getIsWord() -> Bool {
        return isWord
    }
    
    
    func getWord() -> String {
        return word
    }
    
    func setWord(word: String) {
        self.word = word
    }
    
    
    
    func isAnagram() -> Bool {
        if anagrams.isEmpty {
            return false
        }
        
        return true
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
    private func sortString(word: String) -> String{
        let charArray = Array(word.characters)
        let sortedCharArray = charArray.sort( { $0 < $1 } )
        return String(sortedCharArray)
    }
    
  }