//
//  AddBookVC.swift
//  ProlificInteractiveBooks
//
//  Created by Rosario Tarabocchia on 8/17/16.
//  Copyright © 2016 RLDT. All rights reserved.
//

import UIKit
import Alamofire

class AddBookVC: UIViewController {
    

    @IBOutlet weak var bookTitleTxtFld: UITextField!
    
    @IBOutlet weak var authorTxtFld: UITextField!
    
    @IBOutlet weak var publisherTxtFld: UITextField!
    
    @IBOutlet weak var tagsTxtFld: UITextField!
    
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
            
            
        }
        
        else {
            
            print("GOOD TO GO")
            
            let parameters = ["title": "test", "author": "test"]
            
//            uploadBook(parameters, completed:{})
            
            
            
            
            
        
        
        }
        
        
        
    }
    
//    func uploadBook(parameter: [String: AnyObject], completed: DownloadComplete) {
//        
//        let currentBooksUrl = NSURL(string: "\(URL_BASE)\(URL_BOOKS)")!
//        
//        
//        Alamofire.request(.POST, currentBooksUrl, parameters: parameter, encoding: .JSON, headers: nil)
//        
//        completed()
    

        
        
        
        
        
        
        
        
//    }
    


}
