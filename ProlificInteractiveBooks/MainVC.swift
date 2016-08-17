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
    
    @IBOutlet weak var searchBar: UISearchBar!

    @IBOutlet weak var bookTableView: UITableView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bookTableView.delegate = self
        bookTableView.dataSource = self
        searchBar.delegate = self
        
        searchBar.returnKeyType = UIReturnKeyType.Done
        
        self.downloadBooks(){
            
            self.bookTableView.reloadData()
        }
        
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
            // Delete the row from the data source
            booksArray.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            bookTableView.reloadData()

    }
    
    }
    
    

    @IBAction func addBookToList(sender: AnyObject) {
    }
    @IBAction func clearAllBooks(sender: AnyObject) {
    }
    
    
    func downloadBooks(completed: DownloadComplete) {
        
        let currentBooksUrl = NSURL(string: "\(URL_BASE)\(URL_BOOKS)")!
        
        Alamofire.request(.GET, currentBooksUrl).responseJSON { response in
            
            let result = response.result
            
            if let array = result.value as? [Dictionary<String, AnyObject>] {
                
                for obj in array {
                    
                    let bookItem = Book(bookDictionary: obj)
                    
                    self.booksArray.append(bookItem)
                    
                    }
                }
            
            self.bookTableView.reloadData()
            
            }
        
        completed()
            
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


}

