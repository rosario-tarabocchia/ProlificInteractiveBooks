//
//  CheckoutEditVC.swift
//  ProlificInteractiveBooks
//
//  Created by Rosario Tarabocchia on 8/17/16.
//  Copyright © 2016 RLDT. All rights reserved.
//

import UIKit
import Social

class CheckoutEditVC: UIViewController, UITextFieldDelegate{
    
    
    var book: Book!
    var apiCalls = APICalls()
    var titleIsEditing = false
    var authorIsEditing = false
    var publisherIsEditing = false
    var tagsIsEditing = false
    
    
    @IBOutlet weak var returnBtn: UIButton!
    @IBOutlet weak var checkoutBtn: UIButton!
    @IBOutlet weak var submitBtn: UIButton!
    @IBOutlet weak var titleTxtFld: UITextField!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var titleEditBtn: UIButton!
    @IBOutlet weak var authorTxtFld: UITextField!
    @IBOutlet weak var authorLbl: UILabel!
    @IBOutlet weak var authorEditBtn: UIButton!
    @IBOutlet weak var publisherTxtFld: UITextField!
    @IBOutlet weak var publisherLbl: UILabel!
    @IBOutlet weak var publisherEditBtn: UIButton!
    @IBOutlet weak var tagsTxtFld: UITextField!
    @IBOutlet weak var tagsLbl: UILabel!
    @IBOutlet weak var tagsEditBtn: UIButton!
    @IBOutlet weak var checkOutByLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleTxtFld.hidden = true
        authorTxtFld.hidden = true
        publisherTxtFld.hidden = true
        tagsTxtFld.hidden = true
        titleLbl.text = book.title
        authorLbl.text = book.author
        publisherLbl.text = book.publisher
        tagsLbl.text = book.tags
        checkOutByLbl.text = book.lastCheckoutDate
        titleTxtFld.text = book.title
        authorTxtFld.text = book.author
        publisherTxtFld.text = book.publisher
        tagsTxtFld.text = book.tags
        
        if book.lastCheckoutName == "" {
            
            checkOutByLbl.text = "AVAILABLE"
            
        } else {
            
            checkOutByLbl.text = "\(book.lastCheckoutName) on \(book.lastCheckoutDate)"
            
        }

    }
    
    
    @IBAction func backBtnPressed(sender: AnyObject) {
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    @IBAction func facebookBtnPressed(sender: AnyObject) {
        
        if SLComposeViewController.isAvailableForServiceType(SLServiceTypeFacebook){
            
            let facebookShare: SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
            
            facebookShare.setInitialText("Checkout this new book I am reading - \(book.title)")
            
            self.presentViewController(facebookShare, animated: true, completion: nil)
            
        } else {
            
            let alert = UIAlertController(title: "Whoops!", message: "Please login to a Facebook account to share.", preferredStyle: UIAlertControllerStyle.Alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    
    @IBAction func tweetBtnPressed(sender: AnyObject) {
        
        if SLComposeViewController.isAvailableForServiceType(SLServiceTypeTwitter){
            
            let twitterShare: SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
            
            twitterShare.setInitialText("Checkout this new book I am reading - \(book.title)")
            
            self.presentViewController(twitterShare, animated: true, completion: nil)
            
        } else {
            
            let alert = UIAlertController(title: "Whoops!", message: "Please login to a Twitter account to share.", preferredStyle: UIAlertControllerStyle.Alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    
    @IBAction func submitButtonPressed(sender: AnyObject) {
        
        var parameters = [String: String]()
        
        
        if titleTxtFld.text == nil || titleTxtFld.text == "" || authorTxtFld.text == nil || authorTxtFld.text == "" {
            
            print(titleTxtFld.text)
            
            print("Somethign is missing")
            
            let alert = UIAlertController(title: "Uh oh!", message: "You must enter a title and author before submitting.", preferredStyle: .Alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: nil))
            
            presentViewController(alert, animated: true, completion: nil)
            
        }
            
        else {
            
            if titleIsEditing {
                
                parameters["title"] = titleTxtFld.text
                titleLbl.text = titleTxtFld.text
                titleIsEditing = false
                
            }
                
            else {
                
                parameters["title"] = titleLbl.text
                
            }
            
            if authorIsEditing {
                
                parameters["author"] = authorTxtFld.text
                authorLbl.text = authorTxtFld.text
                authorIsEditing = false
                
            }
                
            else {
                
                parameters["author"] = authorLbl.text
                
            }
            
            if publisherIsEditing {
                
                parameters["publisher"] = publisherTxtFld.text
                publisherLbl.text = publisherTxtFld.text
                publisherIsEditing = false
                
            }
                
            else {
                
                parameters["publisher"] = publisherLbl.text
                
            }
            
            if tagsIsEditing {
                
                parameters["categories"] = tagsTxtFld.text
                tagsLbl.text = tagsTxtFld.text
                tagsIsEditing = false
                
            }
                
            else {
                
                parameters["categories"] = tagsLbl.text
                
            }
            
            titleTxtFld.hidden = true
            authorTxtFld.hidden = true
            publisherTxtFld.hidden = true
            tagsTxtFld.hidden = true
            titleLbl.hidden = false
            authorLbl.hidden = false
            publisherLbl.hidden = false
            tagsLbl.hidden = false
            
            apiCalls.updateCheckoutOrReturnBook(book.id, parameters: parameters, complete: {(success) -> Void in
                
                
                if success {
                    
                    self.titleTxtFld.hidden = true
                    self.authorTxtFld.hidden = true
                    self.publisherTxtFld.hidden = true
                    self.tagsTxtFld.hidden = true
                    self.titleLbl.hidden = false
                    self.authorLbl.hidden = false
                    self.publisherLbl.hidden = false
                    self.tagsLbl.hidden = false
                    
                    
                } else {
                    
                    self.errorNotification()
                    
                }
            })
        }
    }
    
    @IBAction func returnBtnPressed(sender: AnyObject) {
        
        var parameters = [String: String]()
        parameters["lastCheckedOutBy"] = ""
        
        
        self.apiCalls.updateCheckoutOrReturnBook(self.book.id, parameters: parameters, complete: {(success) -> Void in
            
            if success {
                
                self.checkOutByLbl.text = ""
      
                
            } else {
                
                self.errorNotification()
                
            }
        })

        
        
        
        
        
        
        
    }
    
    
    
    @IBAction func checkoutBtnPressed(sender: AnyObject) {
        
        var parameters = [String: String]()
        
        var inputTextField: UITextField?
        
        let action: UIAlertController = UIAlertController(title: "Checkout", message: "Please enter yout name.", preferredStyle: .Alert)
        
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .Cancel) { action -> Void in
            
        }
        
        action.addAction(cancelAction)
        
        let nextAction: UIAlertAction = UIAlertAction(title: "OK", style: .Default) { action -> Void in
            if inputTextField?.text == nil || inputTextField?.text == "" {
                print(inputTextField?.text)
                print("Not doing anything")
                
                let alert = UIAlertController(title: "Tisk Tisk Tisk!", message: "You must provide your name to check out a book. Please try again.", preferredStyle: .Alert)
                
                alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: nil))
                
                self.presentViewController(alert, animated: true, completion: nil)
                
                
            } else {
                
                print(inputTextField?.text)
                print("Make API call")
                
                parameters["lastCheckedOutBy"] = inputTextField!.text
                
                let dateformatterAPI = NSDateFormatter()
                
                dateformatterAPI.dateFormat = "yyyy-MM-dd HH:mm:ss"
                
                let nowAPI = dateformatterAPI.stringFromDate(NSDate())
                
                parameters["lastCheckedOut"] = nowAPI
                
                let dateformatterLabel = NSDateFormatter()
                
                dateformatterLabel.dateStyle = .LongStyle
                
                let nowLabel = dateformatterLabel.stringFromDate(NSDate())
                
                self.apiCalls.updateCheckoutOrReturnBook(self.book.id, parameters: parameters, complete: {(success) -> Void in
                    
                if success {
                        
                        if let name = inputTextField!.text {
                            
                            self.checkOutByLbl.text = "\(name) on \(nowLabel)"
                            
                        }
                        
                    } else {
                        
                        self.errorNotification()
                        
                    }
                })
            }
        }
        
        action.addAction(nextAction)
        
        action.addTextFieldWithConfigurationHandler { textField -> Void in
            
            inputTextField = textField
        }
        
        //Present the AlertController
        self.presentViewController(action, animated: true, completion: nil)
    }
    
    
    
    
    
    
    @IBAction func titleEditBtnPressed(sender: AnyObject) {
        
        titleIsEditing = !titleIsEditing
        
        if titleIsEditing {
            
            titleTxtFld.hidden = false
            titleLbl.hidden = true

            
            print(titleTxtFld.text)
            
            
        }
            
        else {
            
            titleTxtFld.hidden = true
            titleLbl.hidden = false

        
        }
        
    }
    
    @IBAction func authorEditBtnPressed(sender: AnyObject) {
        
        authorIsEditing = !authorIsEditing
        
        if authorIsEditing {
            
            authorTxtFld.hidden = false
            authorLbl.hidden = true


            
        }
            
        else {
            
            authorTxtFld.hidden = true
            authorLbl.hidden = false
            
            
        }
        
    }
    
    @IBAction func publisherEditBtnPressed(sender: AnyObject) {
        
        publisherIsEditing = !publisherIsEditing
        
        if publisherIsEditing {
            
            publisherTxtFld.hidden = false
            publisherLbl.hidden = true


            
        }
            
        else {
            
            publisherTxtFld.hidden = true
            publisherLbl.hidden = false

            
        }
        
    }
    
    @IBAction func tagEditBtnPressed(sender: AnyObject) {
        
        tagsIsEditing = !tagsIsEditing
        
        if tagsIsEditing {
            
            tagsTxtFld.hidden = false
            tagsLbl.hidden = true

            
        }
            
        else {
            
            tagsTxtFld.hidden = true
            tagsLbl.hidden = false

            
        }
        
    }
    
    func errorNotification(){
        
        let alert = UIAlertController(title: "Uh Oh!", message: "Something went wrong. Please try again", preferredStyle: .Alert)
        
        
        alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: nil))
        
        
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
       hideKeyboard()
        
    }
    
    func hideKeyboard(){
        
        authorTxtFld.resignFirstResponder()
        titleTxtFld.resignFirstResponder()
        tagsTxtFld.resignFirstResponder()
        publisherTxtFld.resignFirstResponder()
        
        
    }
    
    

    
    
    
}
