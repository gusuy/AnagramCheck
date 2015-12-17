//
//  AnagramCheck.swift
//  AnagramCheck
//
//  Created by Gus Uy on 11/25/15.
//  Copyright (c) 2015 Gus Uy. All rights reserved.
//

import Foundation

class AnagramCheck {
    
    var hashTable: HashTable        // Hash table for all English words
    var word: String                // Stores user input
    var anagrams: [String]          // Holds the resulting anagrams if any
    var isWord:Bool                 // Set to true if user input is a valid word
    //var wordList:[String]           // Holds list of all English words
    
    
    init() {
        hashTable = HashTable()
        word = String()
        anagrams = [String]()
        isWord = false
        //wordList = [String]()
    }
    
    
    
    // Permute all possible letter orders using recursion
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
    
    
    // Iterative binary search to check if word exists
//    private func checkWord (word: String) -> Bool {
//        var first = 0
//        var last = wordList.count - 1
//        
//        while first <= last {
//            let mid = (first + last) / 2
//            if wordList[mid] > word {
//                last = mid - 1
//            }
//            else if wordList[mid] < word {
//                first = mid + 1
//            }
//            else {
//                return true
//            }
//        }
//        
//        return false
//    }
    
    
    // Loads the text file into an array of strings
//    func loadWords() {
//        var filePath = NSBundle.mainBundle().pathForResource("words", ofType: "txt")
//        if let streamReader = StreamReader(path: filePath!) {
//            defer {
//                streamReader.close()
//            }
//            while let line = streamReader.nextLine() {
//                wordList.append(line)
//            }
//        } else {
//            print("File read error")
//        }
//    }
    
    
}