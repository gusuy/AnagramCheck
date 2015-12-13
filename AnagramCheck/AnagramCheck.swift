//
//  AnagramCheck.swift
//  AnagramCheck
//
//  Created by Gus Uy on 11/25/15.
//  Copyright (c) 2015 Gus Uy. All rights reserved.
//

import Foundation

class AnagramCheck {
    
    var word = String()             // stores entered word
    var anagrams = [String]()       // holds the resulting anagrams if any
    var isWord = false              // changes to true if string entered is a word
    var wordList = [String]()       // Holds list of all English words
    
    
    // Permute all possible letter orders using recursion
    func evaluateWord (s1: String, s2: String) {
        let stringSize = s2.characters.count
        if stringSize < 1 {
            if checkWord(s1) {
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
    private func checkWord (var word: String) -> Bool {
        var first = 0
        var last = wordList.count - 1
        word += "\r"                    // Add this because of nature of txt file
        
        while first <= last {
            let mid = (first + last) / 2
            if wordList[mid] > word {
                last = mid - 1
            }
            else if wordList[mid] < word {
                first = mid + 1
            }
            else {
                return true
            }
        }
        
        return false
    }
    
    // Loads the text file into an array of strings
    func loadWords() {
        var filePath = NSBundle.mainBundle().pathForResource("words", ofType: "txt")
        if let streamReader = StreamReader(path: filePath!) {
            defer {
                streamReader.close()
            }
            while let line = streamReader.nextLine() {
                wordList.append(line)
            }
        } else {
            print("File read error")
        }
    }
    
    // MARK: - Extra code
    
    // Checks if word is in the text file (list of English words)
    //    func checkWord (var word: String) -> Bool {
    //        var filePath = NSBundle.mainBundle().pathForResource("words", ofType: "txt")
    //        if let streamReader = StreamReader(path: filePath!) {
    //            defer {
    //                streamReader.close()
    //            }
    //            word += "\r"            // add this because of nature of this particular text file
    //            while let line = streamReader.nextLine() {
    //                if word == line {
    //                    return true
    //                }
    //            }
    //        } else {
    //            print("File read error")
    //        }
    //        
    //        return false
    //    }
    
}