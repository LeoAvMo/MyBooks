//
//  NewBookView.swift
//  MyBooks
//
//  Created by Leo A.Molina on 29/10/25.
//

import SwiftUI

struct NewBookView: View {
    @Environment(\.dismiss) var dismiss
    @State private var title: String = ""
    @State private var author: String = ""
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Title", text: $title)
                TextField("Author", text: $author)
                Button("Create") {
                    dismiss()
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                .buttonStyle(BorderedProminentButtonStyle())
                .disabled(title.isEmpty || author.isEmpty)
            }
            .navigationTitle(Text("New Book"))
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    NewBookView()
}
