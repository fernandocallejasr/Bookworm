//
//  ContentView.swift
//  Bookworm
//
//  Created by Fernando Callejas on 27/07/24.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    
    @Query var books: [Book]
    @State private var showingAddBookScreen = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(books) { book in
                    NavigationLink(value: book) {
                        HStack {
                            EmojiRatingView(rating: book.rating)
                                .font(.largeTitle)
                            
                            VStack(alignment: .leading) {
                                Text(book.title)
                                    .font(.headline)
                                Text(book.author)
                                    .foregroundStyle(.secondary)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Bookworm")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Add Book", systemImage: "plus") {
                        showingAddBookScreen.toggle()
                    }
                }
            }
            .sheet(isPresented: $showingAddBookScreen) {
                AddBookView()
            }
            .navigationDestination(for: Book.self) { selectedBook in
                BookDetailView(book: selectedBook)
            }
        }
    }
}

#Preview {
    ContentView()
}
