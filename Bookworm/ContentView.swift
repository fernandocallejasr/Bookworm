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
            Text("Books Count: \(books.count)")
                .font(.title)
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
        }
    }
}

#Preview {
    ContentView()
}
