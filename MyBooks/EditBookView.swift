//
//  EditBookView.swift
//  MyBooks
//
//  Created by Leo A.Molina on 31/10/25.
//

import SwiftUI

struct EditBookView: View {
//    let book: Book
    @State private var status: Status = .onShelf
    @State private var rating: Int?
    @State private var title: String = ""
    @State private var author: String = ""
    @State private var summary: String = ""
    @State private var dateAdded = Date.distantPast
    @State private var dateStarted = Date.distantPast
    @State private var dateCompleted = Date.distantPast
    
    var body: some View {
        HStack {
            Text("Status")
            Picker("Status", selection: $status) {
                ForEach(Status.allCases) { status in
                    Text(status.description).tag(status)
                }
            }
            .buttonStyle(.glassProminent)
        }
        VStack(alignment: .leading) {
            GroupBox {
                LabeledContent {
                    DatePicker("", selection: $dateAdded, displayedComponents: .date)
                } label: {
                    Text("Date Added")
                }
                
                if status == .inProgress || status == .completed {
                    LabeledContent {
                        DatePicker("", selection: $dateStarted, displayedComponents: .date)
                    } label: {
                        Text("Date Started")
                    }
                }
                
                if status == .completed {
                    LabeledContent {
                        DatePicker("", selection: $dateCompleted, displayedComponents: .date)
                    } label: {
                        Text("Date Completed")
                    }
                }
            }
            .foregroundStyle(.secondary)
            .onChange(of: status) { oldValue, newValue in
                // Changing
                if newValue == .onShelf {
                    // From .completed or .inProgress to .onShelf
                    dateStarted = Date.distantPast
                    dateCompleted = Date.distantPast
                } else if newValue == .inProgress && oldValue == .completed {
                    // From .completed to .inProgress
                    dateCompleted = Date.distantPast
                } else if newValue == .inProgress && oldValue == .onShelf {
                    // Book has been started
                    dateStarted = Date.now
                } else if newValue == .completed && oldValue == .onShelf {
                    // User forgot to add the started date and set .onShelf directly to completed
                    dateStarted = dateAdded
                    dateCompleted = Date.now
                } else {
                    // Completed
                    dateCompleted = Date.now
                }
            }
            
            Divider()
        }
    }
}

#Preview {
    EditBookView()
}
