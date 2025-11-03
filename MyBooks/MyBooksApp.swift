//
//  MyBooksApp.swift
//  MyBooks
//
//  Created by Leo A.Molina on 29/10/25.
//

import SwiftUI
import SwiftData

@main
struct MyBooksApp: App {
    let container: ModelContainer
    var body: some Scene {
        WindowGroup {
            BookListView()
        }
        .modelContainer(container)
    }
    
    init() {
        // Uses the library folder for storing the .store
        let schema = Schema([Book.self])
        let config = ModelConfiguration("MyBooks",schema: schema)
        do {
            container = try ModelContainer(for: schema, configurations: config)
        } catch {
           fatalError("Could not configure the container!")
        }
        // Creating a new .store path for the DB to create a container and get the data from the context. Uses the Documents folder
        /*
        let config = ModelConfiguration(url: URL.documentsDirectory.appending(path: "MyBooks.store"))
        do {
            container = try ModelContainer(for: Book.self, configurations: config)
        } catch {
            fatalError("Could not configure the container!")
        }
        */
        print(URL.documentsDirectory.path())
    }
}
