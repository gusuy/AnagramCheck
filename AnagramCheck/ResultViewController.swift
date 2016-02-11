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
    
    @IBOutlet weak private var tableView: UITableView!
    @IBOutlet weak private var resultLabel: UILabel!
    @IBOutlet weak private var loading: UIActivityIndicatorView!
    
    private var anagramCheck = AnagramCheck()
    
    
    func setModel(model: AnagramCheck) {
        anagramCheck = model
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loading.startAnimating()
        
        // Evaluate word in separate queue
        dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), {
            self.anagramCheck.setAnagrams()
            
            dispatch_async(dispatch_get_main_queue(), {
                self.loading.stopAnimating()
                self.tableView.reloadData()
                if self.anagramCheck.getIsWord() {
                    if self.anagramCheck.isAnagram() {
                        self.resultLabel.text = "\(self.anagramCheck.getWord()) is an anagram."
                    }
                    else {
                        self.resultLabel.text = "\(self.anagramCheck.getWord()) is not an anagram."
                    }
                }
                else {
                    if self.anagramCheck.isAnagram() {
                        self.resultLabel.text = "\(self.anagramCheck.getWord()) is not a word, but is an anagram."
                    }
                    else {
                        self.resultLabel.text = "\(self.anagramCheck.getWord()) is not a word, and is not an anagram."
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
    
    
    // MARK: - UITableViewDataSource Methods
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        
        cell.textLabel?.text = anagramCheck.getAnagrams()[indexPath.row]
        
        return cell
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return anagramCheck.getAnagrams().count
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
}
