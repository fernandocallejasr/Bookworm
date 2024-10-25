//
//  BookDetailView.swift
//  Bookworm
//
//  Created by Fernando Callejas on 28/07/24.
//

import SwiftData
import SwiftUI

struct BookDetailView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    @State private var showingDeleteAlert = false
    
    let book: Book
    
    var body: some View {
        ScrollView {
            ZStack(alignment: .bottomTrailing) {
                Image(book.genre)
                    .resizable()
                    .scaledToFit()
                
                Text(book.genre.uppercased())
                    .font(.caption)
                    .fontWeight(.black)
                    .padding(8)
                    .foregroundStyle(.white)
                    .background(.ultraThinMaterial)
                    .clipShape(.capsule)
                    .offset(x: -5, y: -5)
            }
            
            Text(book.author)
                .font(.title)
                .foregroundStyle(.secondary)
            
            Text(book.review)
                .padding()
            
            RatingView(rating: .constant(book.rating))
                .font(.largeTitle)
            
            Text(book.date.formatted(date: .long, time: .omitted))
                .padding()
                .font(.title3)
                .fontWeight(.light)

            Button {
                showingDeleteAlert.toggle()
            } label: {
                HStack(spacing: 13) {
                    Image(systemName: "trash")
                    Text("Delete Book")
                }
            }
            .padding()
            .background(.thinMaterial)
            .clipShape(.rect(cornerRadius: 25))
            .foregroundStyle(.primary)
            .shadow(color: .black.opacity(0.2), radius: 10)
            .padding(80)
            
        }
        .navigationTitle(book.title)
        .navigationBarTitleDisplayMode(.inline)
        .scrollBounceBehavior(.basedOnSize)
        .alert("Delete Book", isPresented: $showingDeleteAlert) {
            Button("Delete", role: .destructive) {
                modelContext.delete(book)
                dismiss()
            }
            Button("Cancel", role: .cancel) {
                showingDeleteAlert.toggle()
            }
        }
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Book.self, configurations: config)
        let example = Book("Test Book", "Test Author", "Fantasy", "This was a great book; I really enjoyed it.", 4)
        
        return BookDetailView(book: example)
            .modelContainer(container)
    } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
    }
}
