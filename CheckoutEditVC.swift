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
    
    
    @IBOutlet weak var availableImage: UIImageView!
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
    
    //MARK: Override Functions
    
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
        titleTxtFld.text = book.title
        authorTxtFld.text = book.author
        publisherTxtFld.text = book.publisher
        tagsTxtFld.text = book.tags
        
        submitBtn.hidden = true
        
        if book.isAvailable {
            
            availableImage.image = UIImage(named: "avail")
            
            returnBtn.hidden = true
            
        } else {
            
            checkOutByLbl.text = "\(book.lastCheckoutName) on \(book.lastCheckoutDate)"
            
            availableImage.image = UIImage(named: "check")
            
            checkoutBtn.hidden = true
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        hideKeyboard()
        
    }
    
    //Mark: IBActions
    
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
            
            let alert = UIAlertController(title: "Uh oh!", message: "You must enter a title and author before submitting.", preferredStyle: .Alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: nil))
            
            presentViewController(alert, animated: true, completion: nil)
            
        } else {
            
            if titleIsEditing {
                
                parameters["title"] = titleTxtFld.text
                titleLbl.text = titleTxtFld.text
                titleIsEditing = false
                
            } else {
                
                parameters["title"] = titleLbl.text
                
            }
            
            if authorIsEditing {
                
                parameters["author"] = authorTxtFld.text
                authorLbl.text = authorTxtFld.text
                authorIsEditing = false
                
            } else {
                
                parameters["author"] = authorLbl.text
                
            }
            
            if publisherIsEditing {
                
                parameters["publisher"] = publisherTxtFld.text
                publisherLbl.text = publisherTxtFld.text
                publisherIsEditing = false
                
            } else {
                
                parameters["publisher"] = publisherLbl.text
                
            }
            
            if tagsIsEditing {
                
                parameters["categories"] = tagsTxtFld.text
                tagsLbl.text = tagsTxtFld.text
                tagsIsEditing = false
                
            } else {
                
                parameters["categories"] = tagsLbl.text
                
            }
            
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
                    
                    self.tagsEditBtn.setImage(UIImage(named: "redEditButton"), forState: UIControlState.Normal)
                    self.publisherEditBtn.setImage(UIImage(named: "redEditButton"), forState: UIControlState.Normal)
                    self.titleEditBtn.setImage(UIImage(named: "redEditButton"), forState: UIControlState.Normal)
                    self.authorEditBtn.setImage(UIImage(named: "redEditButton"), forState: UIControlState.Normal)
                    
                    self.submitBtn.hidden = true
                    
                    if self.book.isAvailable {
                        
                        self.returnBtn.hidden = true
                        self.checkoutBtn.hidden = false
                        
                        
                    } else {
                        
                        self.checkoutBtn.hidden = true
                        self.returnBtn.hidden = false
                        
                    }
                    
                    
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
                self.returnBtn.hidden = true
                self.checkoutBtn.hidden = false
                self.availableImage.image = UIImage(named: "avail")
                self.book.isAvailable = true
                
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
                
                let alert = UIAlertController(title: "Tisk Tisk Tisk!", message: "You must provide your name to check out a book. Please try again.", preferredStyle: .Alert)
                
                alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: nil))
                
                self.presentViewController(alert, animated: true, completion: nil)
                
                
            } else {
                
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
                            self.returnBtn.hidden = false
                            self.checkoutBtn.hidden = true
                            self.availableImage.image = UIImage(named: "check")
                            self.book.isAvailable = false
                            
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
        
        self.presentViewController(action, animated: true, completion: nil)
    }
    
    @IBAction func titleEditBtnPressed(sender: AnyObject) {
        
        titleIsEditing = !titleIsEditing
        
        if titleIsEditing {
            
            hideCheckoutReturnButtons()
            
            titleTxtFld.hidden = false
            titleLbl.hidden = true
            titleEditBtn.setImage(UIImage(named: "greenEditButton"), forState: UIControlState.Normal)
            
        } else {
            
            checkOtherEdits()
            titleTxtFld.resignFirstResponder()
            titleTxtFld.hidden = true
            titleLbl.hidden = false
            titleEditBtn.setImage(UIImage(named: "redEditButton"), forState: UIControlState.Normal)
        }
        
    }
    
    @IBAction func authorEditBtnPressed(sender: AnyObject) {
        
        authorIsEditing = !authorIsEditing
        
        if authorIsEditing {
            
            hideCheckoutReturnButtons()
            authorTxtFld.hidden = false
            authorLbl.hidden = true
            authorEditBtn.setImage(UIImage(named: "greenEditButton"), forState: UIControlState.Normal)
            
        } else {
            
            checkOtherEdits()
            authorTxtFld.resignFirstResponder()
            authorTxtFld.hidden = true
            authorLbl.hidden = false
            authorEditBtn.setImage(UIImage(named: "redEditButton"), forState: UIControlState.Normal)
            
        }
        
    }
    
    @IBAction func publisherEditBtnPressed(sender: AnyObject) {
        
        publisherIsEditing = !publisherIsEditing
        
        if publisherIsEditing {
            
            hideCheckoutReturnButtons()
            publisherTxtFld.hidden = false
            publisherLbl.hidden = true
            publisherEditBtn.setImage(UIImage(named: "greenEditButton"), forState: UIControlState.Normal)
            
        } else {
            
            checkOtherEdits()
            publisherTxtFld.resignFirstResponder()
            publisherTxtFld.hidden = true
            publisherLbl.hidden = false
            publisherEditBtn.setImage(UIImage(named: "redEditButton"), forState: UIControlState.Normal)
            
        }
        
    }
    
    @IBAction func tagEditBtnPressed(sender: AnyObject) {
        
        tagsIsEditing = !tagsIsEditing
        
        if tagsIsEditing {
            
            hideCheckoutReturnButtons()
            tagsTxtFld.hidden = false
            tagsLbl.hidden = true
            tagsEditBtn.setImage(UIImage(named: "greenEditButton"), forState: UIControlState.Normal)
            
        } else {
            
            checkOtherEdits()
            
            tagsTxtFld.resignFirstResponder()
            tagsTxtFld.hidden = true
            tagsLbl.hidden = false
            tagsEditBtn.setImage(UIImage(named: "redEditButton"), forState: UIControlState.Normal)
            
        }
    }
    
    //MARK: Functions
    
    func errorNotification(){
        
        let alert = UIAlertController(title: "Uh Oh!", message: "Something went wrong. Please try again", preferredStyle: .Alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: nil))
        
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    func hideKeyboard(){
        
        authorTxtFld.resignFirstResponder()
        titleTxtFld.resignFirstResponder()
        tagsTxtFld.resignFirstResponder()
        publisherTxtFld.resignFirstResponder()
        
    }
    
    func hideSubmitButtons(){
        
        submitBtn.hidden = true
        
        if book.isAvailable {
            
            returnBtn.hidden = true
            checkoutBtn.hidden = false
            
            
        } else {
            
            checkoutBtn.hidden = true
            returnBtn.hidden = false
            
        }
        
    }
    
    func hideCheckoutReturnButtons(){
        
        submitBtn.hidden = false
        returnBtn.hidden = true
        checkoutBtn.hidden = true
        
    }
    
    func checkOtherEdits() {
        
        if titleIsEditing || authorIsEditing || publisherIsEditing || tagsIsEditing {
            
            submitBtn.hidden = false
            checkoutBtn.hidden = true
            returnBtn.hidden = true
            
        } else {
            
            hideSubmitButtons()
            
        }
    }
    
}
