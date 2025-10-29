//
//  ContentView.swift
//  MyBooks
//
//  Created by Leo A.Molina on 29/10/25.
//

import SwiftUI

struct BookListView: View {
    @State private var createNewBook = false
    var body: some View {
        NavigationStack{
            List {
                
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
}
