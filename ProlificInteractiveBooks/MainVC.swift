//
//  MainVC.swift
//  ProlificInteractiveBooks
//
//  Created by Rosario Tarabocchia on 8/16/16.
//  Copyright © 2016 RLDT. All rights reserved.
//

import UIKit
import Alamofire

class MainVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    var book : Book!
    var booksArray: [Book] = []
    var filteredBooksArray: [Book] = []
    var inSeachMode = false
    var apiCalls = APICalls()
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var bookTableView: UITableView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bookTableView.delegate = self
        bookTableView.dataSource = self
        searchBar.delegate = self
        
        searchBar.returnKeyType = UIReturnKeyType.Done
        
        apiCalls.getCall({ (array) -> Void in
            
            print("THIS IS IN THE MAIN VC \(array)")
            
            self.booksArray = array
            
            print("We made it")
            
            self.bookTableView.reloadData()
            
        })
        

    }
    
    // Table View Functions
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if inSeachMode {
            
            return filteredBooksArray.count
            
        }
            
        else {
            
            return booksArray.count
            
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCellWithIdentifier("BookCell") as? BookCellTableViewCell {
            
            if inSeachMode {
                
                book = filteredBooksArray[indexPath.row]
                cell.configureCell(book)
            }
                
            else {
                
                book = booksArray[indexPath.row]
                cell.configureCell(book)
            }
            
            return cell
            
        }
            
        else {
            
            return BookCellTableViewCell()
            
        }
        
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
           
            book = booksArray[indexPath.row]

            apiCalls.deleteOneBook(book.id, complete: {(success) -> Void in
            
                if success {
                    
                    self.booksArray.removeAtIndex(indexPath.row)
                    tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
                    self.bookTableView.reloadData()
                    
                    
                }
                
            
            
            
            
            })
            
            
            booksArray.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            bookTableView.reloadData()
            
        }
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let bookSelection : Book!
        
        
        if inSeachMode {
            
            bookSelection = filteredBooksArray[indexPath.row]
            
        } else {
            
            bookSelection = booksArray[indexPath.row]
            
        }
        
        performSegueWithIdentifier("checkoutEditSegue", sender: bookSelection)
        
    }
    
    
    
    
    @IBAction func clearAllBooks(sender: AnyObject) {
        
        
    }
    
    // Search Bar Functions
    // BUG: Keyboard wont dismiss
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        
        view.endEditing(false)
        
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        view.endEditing(true)
        resignFirstResponder()
    }
    
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchBar.text == nil || searchBar.text == "" {
            
            inSeachMode = false
            bookTableView.reloadData()
            resignFirstResponder()
            
        }
            
        else {
            
            inSeachMode = true
            let enteredText = searchBar.text!.lowercaseString
            
            filteredBooksArray = booksArray.filter({$0.title.lowercaseString.rangeOfString(enteredText) != nil})
            
            bookTableView.reloadData()
            
        }
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        print("ARE YOU GETTING CALLED?")
        
        if segue.identifier == "checkoutEditSegue" {
            
            if let bookDetails = segue.destinationViewController as? CheckoutEditVC {
                
                
                print("GEETING TO IF LET INSIDE BOOK DETAILS")
                
                if let book = sender as? Book  {
                    
                    print(book.title)
                    print(book.author)
                    
                    bookDetails.book = book
                    
                    
                    
                }
                
            }
            
        }
    }
    
    
    
    
}

