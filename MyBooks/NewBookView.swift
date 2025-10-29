//
//  NewBookView.swift
//  MyBooks
//
//  Created by Leo A.Molina on 29/10/25.
//

import SwiftUI
import SwiftData

struct NewBookView: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) var dismiss
    @State private var title: String = ""
    @State private var author: String = ""
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Title", text: $title)
                TextField("Author", text: $author)
                Button("Create") {
                    let newBook = Book(title: title, author: author)
                    context.insert(newBook)
                    dismiss()
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                .buttonStyle(BorderedProminentButtonStyle())
                .disabled(title.isEmpty || author.isEmpty)
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Cancel", systemImage: "xmark") {
                            dismiss()
                        }
                    }
                }
            }
            .navigationTitle(Text("New Book"))
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    NewBookView()
}
