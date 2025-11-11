//
//  ContentView.swift
//  MyBooks
//
//  Created by Leo A.Molina on 29/10/25.
//

import SwiftUI
import SwiftData

enum SortOrder: String, CaseIterable, Identifiable {
    case status, title, author
    
    var id: Self { self }
}
struct BookListView: View {
    
    
    @State private var createNewBook = false
    @State private var sortOrder = SortOrder.status
    @State private var searchString = ""
    var body: some View {
        NavigationStack{
            Picker("", selection: $sortOrder){
                ForEach(SortOrder.allCases) { sortOrder in
                    Text("Sort by \(sortOrder.rawValue)").tag(sortOrder)
                }
            }
            .pickerStyle(.menu)
            .buttonStyle(.glass)
            
            BookList(sortOrder: sortOrder, searchString: searchString)
                .searchable(text: $searchString, prompt: Text("Filter on title or author"))
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
