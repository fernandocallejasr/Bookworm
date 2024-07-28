//
//  Book.swift
//  Bookworm
//
//  Created by Fernando Callejas on 28/07/24.
//

import Foundation
import SwiftData

@Model
class Book {
    var title: String
    var author: String
    var genre: String
    var review: String
    var rating: Int
    
    init(_ title: String, _ author: String, _ genre: String, _ review: String, _ rating: Int) {
        self.title = title
        self.author = author
        self.genre = genre
        self.review = review
        self.rating = rating
    }
}
