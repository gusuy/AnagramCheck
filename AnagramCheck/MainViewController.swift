//
//  MainViewController.swift
//  AnagramCheck
//
//  Created by Gus Uy on 11/25/15.
//  Copyright (c) 2015 Gus Uy. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UITextFieldDelegate {
    // TODO: Add text input restrictions and checks - restrict spaces, only words for now, no phrases
    // TODO: Optimize for larger words - fastest way to get all permutations of word
    
    @IBOutlet weak var wordTextField: UITextField!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!        // Constraint of bottom label to move up with keyboard
    
    var anagramCheck = AnagramCheck()
    var alert = UIAlertController(title: "Error", message: nil, preferredStyle: UIAlertControllerStyle.Alert)
    var originalBottomConstraintConstant = CGFloat()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up keyboard show/hide notifications
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillShow:"), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide:"), name: UIKeyboardWillHideNotification, object: nil)
        
        originalBottomConstraintConstant = bottomConstraint.constant
        
        wordTextField.delegate = self
        
        alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default, handler: nil))
        
        anagramCheck.loadWords()
    }
    
    
    // MARK: - Hide/Show keyboard methods
    
    // Move bottom label up when keyboard shows
    func keyboardWillShow(notification: NSNotification) {
        let keyboardFrame: CGRect = (notification.userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
        
        UIView.animateWithDuration(0.1, animations: {
            self.bottomConstraint.constant += keyboardFrame.size.height
            self.view.layoutIfNeeded()
        })
    }
    
    // Return bottom label when keyboard hides
    func keyboardWillHide(notification: NSNotification) {
        UIView.animateWithDuration(0.1, animations: {
            self.bottomConstraint.constant = self.originalBottomConstraintConstant
            self.view.layoutIfNeeded()
        })
    }
    
    // Hide keyboard when view is touched
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        view.endEditing(true)
    }
    
    // UITextFieldDelegate Method
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    // MARK: - Segue methods
    
    // Passes this instance of AnagramCheck to dest VC
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        anagramCheck.word = wordTextField.text!.lowercaseString
        
        if let identifier = segue.identifier {
            switch identifier {
            case "swipeLeftSegue":
                if let resultVC = segue.destinationViewController as? ResultViewController {
                    resultVC.anagramCheck = anagramCheck
                }
            default: break
            }
        }
    }
    
    // If user tries to swipe with no text, deny segue and display message
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
        if (wordTextField.text == "") {
            // TODO: Refine word requirements
            alert.message = "Enter a word"
            presentViewController(alert, animated: true, completion: nil)
            
            return false
        }
        
        else {
            let range = wordTextField.text!.rangeOfCharacterFromSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
            if range != nil {
                alert.message = "No spaces allowed"
                presentViewController(alert, animated: true, completion: nil)
                
                return false
            }
        }

        return true
    }
    
}

