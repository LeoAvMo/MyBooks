//
//  ContentView.swift
//  MyBooks
//
//  Created by Leo A.Molina on 29/10/25.
//

import SwiftUI
import SwiftData

struct BookListView: View {
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
                                Text(book.title)
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
                                                ForEach(0..<rating, id: \.self) { _ in
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
    BookListView()
        .modelContainer(for: Book.self, inMemory: true)
}
