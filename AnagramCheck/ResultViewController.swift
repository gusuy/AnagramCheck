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
    
    @IBOutlet weak fileprivate var tableView: UITableView!
    @IBOutlet weak fileprivate var resultLabel: UILabel!
    @IBOutlet weak fileprivate var loading: UIActivityIndicatorView!
    
    fileprivate var anagramCheck = AnagramCheck()
    
    
    func setModel(_ model: AnagramCheck) {
        anagramCheck = model
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loading.startAnimating()
        
        // Evaluate word in separate queue
        DispatchQueue.global(qos: DispatchQoS.QoSClass.userInitiated).async(execute: {
            self.anagramCheck.setAnagrams()
            
            DispatchQueue.main.async(execute: {
                self.loading.stopAnimating()
                self.tableView.reloadData()
                if self.anagramCheck.getIsWord() {
                    if self.anagramCheck.isAnagram() {
                        self.resultLabel.text = "\(self.anagramCheck.getWord()) is an anagram"
                    }
                    else {
                        self.resultLabel.text = "\(self.anagramCheck.getWord()) is not an anagram"
                    }
                }
                else {
                    if self.anagramCheck.isAnagram() {
                        self.resultLabel.text = "\(self.anagramCheck.getWord()) is not a word, but is an anagram"
                    }
                    else {
                        self.resultLabel.text = "\(self.anagramCheck.getWord()) is not a word"
                    }
                }
            })
        })
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        // Hide excess cells
        tableView.tableFooterView = UIView(frame: CGRect.zero)
    }
    
    
    // To have swipe-to-previous view controller work on the UITableView
    @IBAction func goBack(_ sender: UISwipeGestureRecognizer) {
        navigationController?.popViewController(animated: true)
    }
    
    
    // MARK: - UITableViewDataSource Methods
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = anagramCheck.getAnagrams()[(indexPath as NSIndexPath).row]
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return anagramCheck.getAnagrams().count
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
}
