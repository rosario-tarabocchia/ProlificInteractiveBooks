//
//  Array+RemoveObject.swift
//  ProlificInteractiveBooks
//
//  Created by Rosario Tarabocchia on 8/18/16.
//  Copyright © 2016 RLDT. All rights reserved.
//

import Foundation

extension Array where Element: AnyObject {
    mutating func remove(object: Element) {
        if let index = indexOf({ $0 === object }) {
            removeAtIndex(index)
        }
    }
}
