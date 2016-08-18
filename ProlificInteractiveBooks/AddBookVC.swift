//
//  AddBookVC.swift
//  ProlificInteractiveBooks
//
//  Created by Rosario Tarabocchia on 8/17/16.
//  Copyright © 2016 RLDT. All rights reserved.
//

import UIKit


class AddBookVC: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var bookTitleTxtFld: UITextField!
    @IBOutlet weak var authorTxtFld: UITextField!
    @IBOutlet weak var publisherTxtFld: UITextField!
    @IBOutlet weak var tagsTxtFld: UITextField!
    
    var apiCalls = APICalls()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func backButtonPressed(sender: AnyObject) {
        
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    @IBAction func submitButtonPressed(sender: AnyObject) {
        
        addBook()
    }
    
    
    func addBook(){
        
        if (bookTitleTxtFld.text == nil || bookTitleTxtFld.text == "") || (authorTxtFld.text == nil || authorTxtFld.text == "") {
            
            print("Somethign is missing")
            
            let alert = UIAlertController(title: "Uh oh!", message: "You must enter a title and author before submitting.", preferredStyle: .Alert)
            
            
            alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: nil))
            
            
            presentViewController(alert, animated: true, completion: nil)
            
            
        } else {
            
            let parameters = ["title": bookTitleTxtFld.text as! AnyObject, "author": authorTxtFld.text as! AnyObject, "publisher": publisherTxtFld.text as! AnyObject, "categories": tagsTxtFld.text as! AnyObject]
            
            apiCalls.addBook(parameters, complete: {(success) -> Void in
                
                if success {
                    
                    self.dismissViewControllerAnimated(true, completion: nil)
                    
                } else {
                    
                    let alert = UIAlertController(title: "Uh Oh!", message: "Something went wrong. Please try again", preferredStyle: .Alert)
                    
                    
                    alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: nil))
                    
                    
                    self.presentViewController(alert, animated: true, completion: nil)
                    
                }
            })
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        hideKeyboard()  
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    func hideKeyboard(){
        
        authorTxtFld.resignFirstResponder()
        bookTitleTxtFld.resignFirstResponder()
        tagsTxtFld.resignFirstResponder()
        publisherTxtFld.resignFirstResponder()
        
        
    }
    
    
}
