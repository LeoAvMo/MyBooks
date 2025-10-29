//
//  ContentView.swift
//  MyBooks
//
//  Created by Leo A.Molina on 29/10/25.
//

import SwiftUI

struct BookListView: View {
    var body: some View {
        NavigationStack{
            List {
                
            }
            .navigationTitle(Text("My Books"))
            .toolbar{
                Button {
                    
                } label: {
                    Image(systemName: "plus.cirle.fill")
                        .imageScale(.large)
                        .tint(.blue)
                }
            }
        }
    }
}

#Preview {
    BookListView()
}
