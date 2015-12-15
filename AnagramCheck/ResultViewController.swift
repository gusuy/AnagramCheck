//
//  ResultViewController.swift
//  AnagramCheck
//
//  Created by Gus Uy on 11/25/15.
//  Copyright (c) 2015 Gus Uy. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    // May make cells clickable, show definition
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var loading: UIActivityIndicatorView!
    
    var anagramCheck = AnagramCheck()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loading.startAnimating()
        
        // Clear anagram array before filling
        anagramCheck.anagrams.removeAll()
        
        // Evaluate word in separate queue
        dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), {
            self.anagramCheck.evaluateWord("", s2: self.anagramCheck.word)

            dispatch_async(dispatch_get_main_queue(), {
                self.loading.stopAnimating()
                self.tableView.reloadData()
                if self.anagramCheck.isWord {
                    if self.anagramCheck.anagrams.isEmpty {
                        self.resultLabel.text = "\(self.anagramCheck.word) is not an anagram."
                    }
                    else {
                        self.resultLabel.text = "\(self.anagramCheck.word) is an anagram."
                    }
                }
                else {
                    if self.anagramCheck.anagrams.isEmpty {
                        self.resultLabel.text = "\(self.anagramCheck.word) is not a word, and is not an anagram."
                    }
                    else {
                        self.resultLabel.text = "\(self.anagramCheck.word) is not a word, but is an anagram."
                    }
                }
            })
        })
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    
    // To have swipe-to-previous view controller work on the UITableView
    @IBAction func goBack(sender: UISwipeGestureRecognizer) {
        navigationController?.popViewControllerAnimated(true)
    }
    
    
    // MARK: - UITableViewDelegate Methods
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        
        cell.textLabel?.text = anagramCheck.anagrams[indexPath.row]
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return anagramCheck.anagrams.count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
}
