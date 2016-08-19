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
    var booksArray = [Book]()
    var filteredBooksArray = [Book]()
    var availableBooksArray = [Book]()
    var bothFilterSearchArray = [Book]()
    var inSeachMode = false
    var apiCalls = APICalls()
    
    @IBOutlet weak var searchBookBar: UISearchBar!
    @IBOutlet weak var bookTableView: UITableView!
    @IBOutlet weak var bookAvailableLbl: UILabel!
    @IBOutlet weak var bookSwitchOutlet: UISwitch!
    
    //MARK: Override Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bookTableView.delegate = self
        bookTableView.dataSource = self
        searchBookBar.delegate = self
        searchBookBar.returnKeyType = UIReturnKeyType.Done
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        
        downloadBooks()
        searchBookBar.text = ""
        inSeachMode = false
        bookSwitchOutlet.on = false
        bookTableView.reloadData()
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "checkoutEditSegue" {
            
            if let bookDetails = segue.destinationViewController as? CheckoutEditVC {
                
                if let book = sender as? Book  {
                    
                    bookDetails.book = book
                    
                }
            }
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        self.view.endEditing(true)
        
    }
    
    //MARK: Table View Functions
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if inSeachMode && bookSwitchOutlet.on {
            
            return bothFilterSearchArray.count
            
        }
            
        else if !inSeachMode && bookSwitchOutlet.on {
            
            return availableBooksArray.count
            
        }
            
        else if inSeachMode && !bookSwitchOutlet.on {
            
            return filteredBooksArray.count
            
        }
            
        else {
            
            return booksArray.count
            
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCellWithIdentifier("BookCell") as? BookCellTableViewCell {
            
            if inSeachMode && bookSwitchOutlet.on {
                
                book = bothFilterSearchArray[indexPath.row]
                cell.configureCell(book)
                
            }
                
            else if !inSeachMode && bookSwitchOutlet.on {
                
                book = availableBooksArray[indexPath.row]
                cell.configureCell(book)
                
            }
                
            else if inSeachMode && !bookSwitchOutlet.on {
                
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
            
            if inSeachMode && bookSwitchOutlet.on {
                
                book = bothFilterSearchArray[indexPath.row]
                
            }
                
            else if !inSeachMode && bookSwitchOutlet.on {
                
                book = availableBooksArray[indexPath.row]
                
            }
                
            else if inSeachMode && !bookSwitchOutlet.on {
                
                book = filteredBooksArray[indexPath.row]
                
            }
                
            else {
                
                book = booksArray[indexPath.row]
            }
            
            
            
            apiCalls.deleteOneBook(book.id, complete: {(success) -> Void in
                
                if success {
                    
                    self.removeBookFromAllArrays(self.book)
                    
                    tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
                    self.bookTableView.reloadData()
                    
                }
            })
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let bookSelection : Book!
        
        if inSeachMode && bookSwitchOutlet.on {
            
            bookSelection = bothFilterSearchArray[indexPath.row]
            
        }
            
        else if !inSeachMode && bookSwitchOutlet.on {
            
            bookSelection = availableBooksArray[indexPath.row]
            
        }
            
        else if inSeachMode && !bookSwitchOutlet.on {
            
            bookSelection = filteredBooksArray[indexPath.row]
            
        }
            
        else {
            
            bookSelection = booksArray[indexPath.row]
        }
        
        performSegueWithIdentifier("checkoutEditSegue", sender: bookSelection)
        
    }
    
    //MARK: Search Bar Functions
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        
        self.view.endEditing(true)
        
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        
        self.view.endEditing(true)
    }
    
    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        
        self.view.endEditing(true)
    }
    
    func searchBarShouldReturn(searchBar: UISearchBar) -> Bool {
        
        self.view.endEditing(true)
        return false
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchBar.text == nil || searchBar.text == "" {
            
            inSeachMode = false
            bookTableView.reloadData()
            self.view.endEditing(true)
            
        }
            
        else {
            
            inSeachMode = true
            
            let enteredText = searchBar.text!.lowercaseString
            
            if bookSwitchOutlet.on {
                
                bothFilterSearchArray = filterArraysWithMultipleParameters(availableBooksArray, enteredText: enteredText)
                
                
            } else {
                
                filteredBooksArray = filterArraysWithMultipleParameters(booksArray, enteredText: enteredText)
                
                
            }
            
            bookTableView.reloadData()
            
        }
    }
    
    func searchBarShouldEndEditing(searchBar: UISearchBar) -> Bool {
        searchBookBar.resignFirstResponder()
        return true
    }
    
    
    //MARK: IBActions
    
    @IBAction func clearAllBooks(sender: AnyObject) {
        
        let action: UIAlertController = UIAlertController(title: "Delete All?", message: "Are you sure you want to delete all the books from the list?", preferredStyle: .Alert)
        
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .Cancel) { action -> Void in
            
        }
        
        action.addAction(cancelAction)
        
        let nextAction: UIAlertAction = UIAlertAction(title: "OK", style: .Default) { action -> Void in
            
            self.apiCalls.deleteAllBooks({(success) -> Void in
                
                if !success {
                    
                    self.booksArray.removeAll()
                    self.availableBooksArray.removeAll()
                    self.bothFilterSearchArray.removeAll()
                    self.filteredBooksArray.removeAll()
                    self.bookTableView.reloadData()
                    
                    let alert = UIAlertController(title: "Book List Deleted", message: "You have successfully deleted all the books on the list.", preferredStyle: .Alert)
                    
                    
                    alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: nil))
                    
                    
                    self.presentViewController(alert, animated: true, completion: nil)
                    
                    
                } else {
                    
                    let alert = UIAlertController(title: "Uh Oh!", message: "Something went wrong. Please try again", preferredStyle: .Alert)
                    
                    
                    alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: nil))
                    
                    
                    self.presentViewController(alert, animated: true, completion: nil)
                }
            })
            
        }
        
        action.addAction(nextAction)
        
        self.presentViewController(action, animated: true, completion: nil)
        
    }
    
    @IBAction func bookSwitch(sender: AnyObject) {
        
        if bookSwitchOutlet.on {
            
            bookAvailableLbl.text = "books available"
            bookAvailableLbl.textColor = UIColor(red: 0.478, green: 0.753, blue: 0.27, alpha: 1.0)
            
            if inSeachMode {
                
                bothFilterSearchArray = filteredBooksArray.filter({$0.lastCheckoutName == ""})
            } else {
                
                availableBooksArray = booksArray.filter({$0.lastCheckoutName == ""})
                
            }
            
        } else {
            
            bookAvailableLbl.text = "all books"
            bookAvailableLbl.textColor = UIColor.darkGrayColor()
            
        }
        
        bookTableView.reloadData()
    }
    
    @IBAction func prolificBtnPressed(sender: AnyObject) {
        
        let openLink = NSURL(string : "http://www.prolificinteractive.com/")
        UIApplication.sharedApplication().openURL(openLink!)
        
        
    }
    
    
    //MARK: Functions
    
    func downloadBooks(){
        
        apiCalls.getBooks({ (array) -> Void in
            
            self.booksArray = array
            
            self.bookTableView.reloadData()
            
        })
    }
    
    func filterArraysWithMultipleParameters(array: [Book], enteredText: String) -> [Book] {
        
        var newArray = [Book]()
        
        newArray = array.filter({$0.title.lowercaseString.rangeOfString(enteredText) != nil})
        
        newArray += array.filter({$0.author.lowercaseString.rangeOfString(enteredText) != nil})
        
        newArray += array.filter({$0.tags.lowercaseString.rangeOfString(enteredText) != nil})
        
        newArray += array.filter({$0.publisher.lowercaseString.rangeOfString(enteredText) != nil})
        
        return newArray
        
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    func removeBookFromAllArrays(book: Book){
        
        self.filteredBooksArray.remove(book)
        self.booksArray.remove(book)
        self.availableBooksArray.remove(book)
        self.bothFilterSearchArray.remove(book)
        
    }
    
    
}



