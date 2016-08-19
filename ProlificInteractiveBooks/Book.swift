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
    private var _isAvailable: Bool!
    
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
        
        return _tags
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
    
    var lastCheckoutDate: String {
        
        if _lastCheckoutDate == nil || _lastCheckoutDate == "" {
            
            _lastCheckoutDate = "1979-09-06 2:14:23"
            
        }
        
        return reformatDateStamp(_lastCheckoutDate)
    }
    
    var isAvailable: Bool {
        
        get {
        
        if _lastCheckoutName == "" {
            
            self._isAvailable = true
            
        } else {
            
            self._isAvailable = false
            
        }
        
            return _isAvailable }
        
        set {
            
            _isAvailable = newValue
        }
    }
    
    
    init(bookDictionary: Dictionary<String, AnyObject>) {
        
        
        if let authorName = bookDictionary["author"] as? String {
            
            self._author = authorName
            
        }
        
        if let bookTitle = bookDictionary["title"] as? String {
            
            self._title = bookTitle
            
        }
        
        if let categories = bookDictionary["categories"] as? String {
            
            self._tags = categories
            
        }
        
        if let publish = bookDictionary["publisher"] as? String {
            
            self._publisher = publish
            
        }
        
        if let checkoutDate = bookDictionary["lastCheckedOut"] as? String {
            
            self._lastCheckoutDate = checkoutDate
            
        }
        
        if let checkoutPerson = bookDictionary["lastCheckedOutBy"] as? String {
            
            self._lastCheckoutName = checkoutPerson
            
        }
        
        if let bookID = bookDictionary["id"] as? Int {
            
            self._id = bookID
            
        }
        
    }
    
    
    
    func reformatDateStamp(dateString: String) -> String {
        
        var newDate = NSDate()
        
        let dateFormatterFromString = NSDateFormatter()
        dateFormatterFromString.dateFormat = "yyyy-MM-dd HH:mm:ss"
        newDate = dateFormatterFromString.dateFromString(dateString)!
        
        let dateFormatterToString = NSDateFormatter()
        dateFormatterToString.dateStyle = .LongStyle
        let newDateString = dateFormatterToString.stringFromDate(newDate)
        
        return newDateString
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
}
