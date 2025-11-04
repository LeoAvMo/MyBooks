//
//  BookList.swift
//  MyBooks
//
//  Created by Leo A.Molina on 04/11/25.
//

import SwiftUI
import SwiftData

struct BookList: View {
    @Environment(\.modelContext) private var context
    @Query private var books: [Book]

    init(sortOrder: SortOrder, searchString: String) {
        let sortDescriptors: [SortDescriptor<Book>] = switch sortOrder {
            case .title:
                [SortDescriptor(\Book.title)]
            case .status:
                [SortDescriptor(\Book.status), SortDescriptor(\Book.title)]
            case .author:
                [SortDescriptor(\Book.author)]
        }
        let predicate = #Predicate<Book> { book in
            book.title.localizedStandardContains(searchString)  // Handles lowercases and uppercases
            || book.author.localizedStandardContains(searchString)
            || searchString.isEmpty // Return all values from the list if the searchString is empty
        }
        
        _books = Query(filter: predicate, sort: sortDescriptors)
    }
    
    var body: some View {
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
                                    if let rating = book.rating, rating > 0 {
                                        HStack {
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
        
    }
}

#Preview {
    let preview: Preview = Preview(Book.self)
    preview.addExamples(Book.sampleBooks)
    return NavigationStack{
        BookList(sortOrder: .status, searchString: "")
    }
        .modelContainer(preview.container)
}
