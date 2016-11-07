//
//  MainViewController.swift
//  AnagramCheck
//
//  Created by Gus Uy on 11/25/15.
//  Copyright (c) 2015 Gus Uy. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UITextFieldDelegate {
    // May add phrase evaluation
    
    @IBOutlet weak fileprivate var wordTextField: UITextField!
    @IBOutlet weak fileprivate var bottomConstraint: NSLayoutConstraint!    // Bottom constraint of bottom label to move up with keyboard
    
    fileprivate var anagramCheck = AnagramCheck()
    fileprivate var alert = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertControllerStyle.alert)
    fileprivate var originalBottomConstraintConstant = CGFloat()            // Reset bottom label position when keyboard hides
    fileprivate var keyboardIsShown = false                                 // Track state of keyboard to prevent issue of UIKeyboardWillShowNotification calling twice on device rotation while keyboard is already showing
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "AnagramCheck"
        
        // Set up keyboard show/hide notification observers
        NotificationCenter.default.addObserver(self, selector: #selector(MainViewController.keyboardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(MainViewController.keyboardWillHide(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        originalBottomConstraintConstant = bottomConstraint.constant
        
        wordTextField.delegate = self
        wordTextField.autocorrectionType = UITextAutocorrectionType.no
        wordTextField.autocapitalizationType = UITextAutocapitalizationType.none
        
        alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
        
        anagramCheck.readFile()
    }
    
    
    // MARK: - Hide/Show keyboard methods
    
    
    // Move bottom label up when keyboard shows
    func keyboardWillShow(_ notification: Notification) {
        if !keyboardIsShown {
            keyboardIsShown = true

            let keyboardFrame: CGRect = ((notification as NSNotification).userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
            
            UIView.animate(withDuration: 0, animations: {
                self.bottomConstraint.constant += keyboardFrame.size.height
                self.view.layoutIfNeeded()
            })
        }
    }
    
    
    // Return bottom label when keyboard hides
    func keyboardWillHide(_ notification: Notification) {
        if keyboardIsShown {
            keyboardIsShown = false
            
            UIView.animate(withDuration: 0, animations: {
                self.bottomConstraint.constant = self.originalBottomConstraintConstant
                self.view.layoutIfNeeded()
            })
        }
    }
    
    
    // Hide keyboard when view is touched
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    
    // UITextFieldDelegate Method
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    // MARK: - Segue methods
    
    
    // Passes this instance of AnagramCheck to dest VC
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        anagramCheck.setWord(wordTextField.text!.lowercased())
        
        if let identifier = segue.identifier {
            switch identifier {
            case "swipeLeftSegue":
                if let resultVC = segue.destination as? ResultViewController {
                    resultVC.setModel(anagramCheck)
                }
            default: break
            }
        }
    }
    
    
    // If user tries to input invalid string, deny segue and display message
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        // Check for empty text field
        if (wordTextField.text == "") {
            alert.message = "Enter a word"
            present(alert, animated: true, completion: nil)
            
            return false
        }
        // Check for spaces
        else if wordTextField.text!.rangeOfCharacter(from: CharacterSet.whitespacesAndNewlines) != nil{
            alert.message = "No spaces allowed"
            present(alert, animated: true, completion: nil)
            
            return false
        }
        // Check for non letter characters
        else if wordTextField.text!.rangeOfCharacter(from: CharacterSet.letters.inverted) != nil {
            alert.message = "Only letters allowed"
            present(alert, animated: true, completion: nil)
            
            return false
        }

        return true
    }
    
}

