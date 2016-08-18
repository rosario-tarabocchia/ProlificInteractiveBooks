//
//  BookCellTableViewCell.swift
//  ProlificInteractiveBooks
//
//  Created by Rosario Tarabocchia on 8/16/16.
//  Copyright © 2016 RLDT. All rights reserved.
//

import UIKit

class BookCellTableViewCell: UITableViewCell {
    
//    @IBOutlet weak var bookTitleLbl: UILabel!

    @IBOutlet weak var bookTitleLbl: UILabel!
    @IBOutlet weak var bookAuthorLbl: UILabel!
    
    @IBOutlet weak var cellImage: UIImageView!
    func configureCell(book: Book) {
        
        print(book.lastCheckoutName)
        
        if book.lastCheckoutName == "" {
            
            cellImage.image = UIImage(named: "side")
            
            
        } else {
            
            
            cellImage.image = UIImage(named: "notebook")
            
            
        }
        
//        bookTitleLbl.text = "TITLE"
        bookAuthorLbl.text = "By: \(book.author)"
        bookTitleLbl.text = "\(book.title)"
        
    }



}
