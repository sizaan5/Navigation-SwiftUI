//
//  ContentView.swift
//  Navigation
//
//  Created by Izaan Saleem on 21/02/2024.
//

import SwiftUI

struct DetailView: View {
    var number: Int

    var body: some View {
        Text("Detail View \(number)")
    }

    init(number: Int) {
        self.number = number
        print("Creating detail view \(number)")
    }
}

struct Student: Hashable {
    var id = UUID()
    var name: String
    var age: Int
}

struct ContentView: View {
    var body: some View {
        NavigationStack {
            List(0..<4) { i in
                NavigationLink("Select \(i)", value: i)
            }
            .navigationDestination(for: Int.self) { selection in
                Text("You selected: \(selection)")
            }
            .navigationDestination(for: Student.self) { student in
                Text("You selected: \(student.name)")
            }
            NavigationLink("Tap Me") {
                List(0..<1000) { i in
                    NavigationLink("Tap Me") {
                        DetailView(number: i)
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
