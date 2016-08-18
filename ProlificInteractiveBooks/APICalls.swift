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
    
    //    var booksArray = [Book]()
    
    let URL_BASE = "http://prolific-interview.herokuapp.com/57b2232707c56b000966dd3e/books/"
    
    
    
    typealias DownloadComplete = (success: Bool) -> ()
    
    init(){}
    
    func getCall(complete:(array:[Book]) -> ()){
        
        var booksArray = [Book]()
        
        Alamofire.request(.GET, URL_BASE).responseJSON { response in
            
            let result = response.result
            
            if let array = result.value as? [Dictionary<String, AnyObject>] {
                
                for obj in array {
                    
                    let bookItem = Book(bookDictionary: obj)
                    
                    booksArray.append(bookItem)
                    
                }
                print(booksArray)
                complete(array: booksArray)
            }
        }
    }
    
    
    func deleteOneBook(bookID: Int, complete: DownloadComplete){
        
        Alamofire.request(.DELETE, "\(URL_BASE)\(bookID)").validate().responseJSON { response in
            
            switch response.result {
            case .Success:
                complete(success: true)
            case .Failure:
                complete(success: false)
            }
        }
        
        
        
    }
    
    
    
}



































