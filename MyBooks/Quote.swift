//
//  Quote.swift
//  MyBooks
//
//  Created by Leo A.Molina on 11/11/25.
//

import Foundation
import SwiftData

@Model
class Quote {
    var quote: String
    
    init(quote: String = "") {
        self.quote = quote
    }
}
