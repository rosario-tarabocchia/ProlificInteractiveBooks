//
//  Book.swift
//  ProlificInteractiveBooks
//
//  Created by Rosario Tarabocchia on 8/16/16.
//  Copyright © 2016 RLDT. All rights reserved.
//

import Foundation
import Alamofire

class Book {
    
    private var _author: String!
    private var _title: String!
    private var _tags: String!
    private var _publisher: String!
    private var _id: Int!
    private var _bookUrl: String!
    private var _lastCheckoutName: String!
    private var _lastCheckoutDate: String!
    
    var author: String {
        if _author == nil {
            
            _author = ""
            
        }
        
        return _author
    }
    
    var title: String {
        if _title == nil {
            
            _title = ""
            
        }
        
        return _title
    }
    
    var tags: String {
        if _tags == nil {
            
            _tags = ""
            
        }
        
        return _author
    }
    
    var publisher: String {
        if _publisher == nil {
            
            _publisher = ""
            
        }
        
        return _publisher
    }
    
    var id: Int {

        return _id
    }
    
    var bookUrl: String {
        if _bookUrl == nil {
            
            _bookUrl = ""
            
        }
        
        return _bookUrl
    }
    
    var lastCheckoutName: String {
        if _lastCheckoutName == nil {
            
            _lastCheckoutName = ""
            
        }
        
        return _lastCheckoutName
    }
    
    
    init(bookDictionary: Dictionary<String, AnyObject>) {
        
        
        if let authorName = bookDictionary["author"] as? String {
        
            self._author = authorName
            print("AUTHOR \(self._author)")
            
        }
        
        if let bookTitle = bookDictionary["title"] as? String {
            
            self._title = bookTitle
            print("TITLE \(self._title)")
            
        }
        
        if let categories = bookDictionary["categories"] as? String {
            
            self._tags = categories
            print("TAGS \(self._tags)")
            
        }
        
        if let publish = bookDictionary["categories"] as? String {
            
            self._publisher = publish
            print("PUBLISHER \(self._publisher)")
            
        }
        
        
    }
    
    
     
    
    
    
    
    
    
    
    
    
    
    
    
    
}
