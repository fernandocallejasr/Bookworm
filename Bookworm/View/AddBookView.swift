//
//  AddBookView.swift
//  Bookworm
//
//  Created by Fernando Callejas on 28/07/24.
//

import SwiftData
import SwiftUI

struct AddBookView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    @State private var title = ""
    @State private var author = ""
    @State private var rating = 3
    @State private var genre = "Fantasy"
    @State private var review = ""
    
    private var allowBookSave: Bool {
        return title.isEmpty || author.isEmpty
    }
    
    let genres = ["Fantasy", "Horror", "Kids", "Mystery", "Poetry", "Romance", "Thriller"]
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Name of book", text: $title)
                    TextField("Author's name", text: $author)
                    
                    Picker("Genre", selection: $genre) {
                        ForEach(genres, id: \.self) { genreSelection in
                            Text(genreSelection)
                        }
                    }
                }
                
                Section("Write a review") {
                    TextEditor(text: $review)
                    
                    Picker("Rating", selection: $rating) {
                        ForEach(0..<6) { rate in
                            Text(String(rate))
                        }
                    }
                }
                
                Section {
                    Button("Save") {
                        let newBook = Book(title, author, genre, review, rating)
                        modelContext.insert(newBook)
                        
                        dismiss()
                    }
                }
                .disabled(allowBookSave)
                
            }
            .navigationTitle("Add Book")
        }
    }
}

#Preview {
    AddBookView()
}
