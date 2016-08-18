//
//  APICalls.swift
//  ProlificInteractiveBooks
//
//  Created by Rosario Tarabocchia on 8/17/16.
//  Copyright © 2016 RLDT. All rights reserved.
//

import Foundation
import Alamofire

class APICalls {
    
    let URL_BASE = "http://prolific-interview.herokuapp.com/57b2232707c56b000966dd3e/"
    let URL_BOOKS = "books/"
    let URL_CLEAR = "clear/"
    
    typealias DownloadComplete = (success: Bool) -> ()
    
    init(){}
    
    func getBooks(complete:(array:[Book]) -> ()){
        
        var booksArray = [Book]()
        
        Alamofire.request(.GET, URL_BASE + URL_BOOKS).responseJSON { response in
            
            let result = response.result
            
            switch response.result {
            case .Success:
                
                if let array = result.value as? [Dictionary<String, AnyObject>] {
                    
                    for obj in array {
                        
                        let bookItem = Book(bookDictionary: obj)
                        
                        booksArray.append(bookItem)
                        
                    }
                    
                    complete(array: booksArray)
                }
                
            case .Failure:
                
                complete(array: [])
            }
        }
    }
    
    
    func deleteOneBook(bookID: Int, complete: DownloadComplete){
        
        Alamofire.request(.DELETE, "\(URL_BASE)\(URL_BOOKS)\(bookID)").validate().responseJSON { response in
            
            switch response.result {
            case .Success:
                complete(success: true)
            case .Failure:
                complete(success: false)
            }
        }
    }
    
    
    func deleteAllBooks(complete: DownloadComplete){
        
        Alamofire.request(.DELETE, URL_BASE + URL_CLEAR).validate().responseJSON { response in
            
            switch response.result {
            case .Success:
                complete(success: true)
            case .Failure:
                complete(success: false)
            }
        }
    }
    
    func addBook(parameters: [String: AnyObject]?, complete: DownloadComplete){
        
        Alamofire.request(.POST, URL_BASE + URL_BOOKS, parameters: parameters, encoding: .JSON, headers: nil).validate().responseJSON { response in
            
            switch response.result {
            case .Success:
                complete(success: true)
            case .Failure:
                complete(success: false)
            }
        }
    }
    
    func updateCheckoutOrReturnBook(bookID: Int, parameters: [String: AnyObject]?, complete: DownloadComplete){
        
        Alamofire.request(.PUT, "\(URL_BASE)\(URL_BOOKS)\(bookID)", parameters: parameters, encoding: .JSON, headers: nil).validate().responseJSON { response in
            
            switch response.result {
            case .Success:
                complete(success: true)
            case .Failure:
                complete(success: false)
            }
        }
    }
    
}



































