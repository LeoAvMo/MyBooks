//
//  ContentView.swift
//  MyBooks
//
//  Created by Leo A.Molina on 29/10/25.
//

import SwiftUI
import SwiftData

struct BookListView: View {
    @Environment(\.modelContext) private var context
    @Query(sort: \Book.title) private var books: [Book]
    @State private var createNewBook = false
    var body: some View {
        NavigationStack{
            Group {
                if books.isEmpty {
                    ContentUnavailableView("No books yet",systemImage: "book.fill")
                } else {
                    List {
                        ForEach(books) { book in
                            NavigationLink{
                                EditBookView(book: book)
                            } label: {
                                HStack(spacing: 10) {
                                    book.icon
                                    VStack(alignment: .leading){
                                        Text(book.title)
                                            .font(.title2)
                                        Text(book.author)
                                            .font(.subheadline)
                                            .foregroundStyle(.secondary)
                                         
                                        // Unwrapping the book's rating
                                        if let rating = book.rating {
                                            HStack{
                                                ForEach(1..<rating, id: \.self) { _ in
                                                    Image(systemName: "star.fill")
                                                        .imageScale(.small)
                                                        .symbolRenderingMode(.multicolor)
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        .onDelete { indexSet in
                            indexSet.forEach { index in
                                let book = books[index]
                                context.delete(book)
                            }
                        }
                    }
                    .listStyle(.plain)
                }
            }
            .navigationTitle(Text("My Books"))
            .toolbar {
                Button {
                    createNewBook.toggle()
                } label: {
                    Image(systemName: "plus")
                        .imageScale(.large)
                        .foregroundStyle(.blue)
                }
            }
            .sheet(isPresented: $createNewBook) {
                NewBookView()
                    .presentationDetents([.medium])
            }
        }
    }
}

#Preview {
    let preview = Preview(Book.self)
    preview.addExamples(Book.sampleBooks)
    return BookListView()
        .modelContainer(preview.container)
}
