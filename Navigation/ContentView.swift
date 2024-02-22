//
//  ContentView.swift
//  Navigation
//
//  Created by Izaan Saleem on 21/02/2024.
//

import SwiftUI

struct DetailView: View {
    var number: Int
    //@Binding var path: [Int]
    @Binding var path: NavigationPath
    
    var body: some View {
        NavigationLink("Go to Random number", value: Int.random(in: 1...1000))
            .navigationTitle("Number: \(number)")
            .toolbar {
                Button("Home") {
                    //path.removeAll()
                    path = NavigationPath()
                }
            }
    }
}

@Observable class PathStore {
    var path: NavigationPath {
        didSet {
            save()
        }
    }
    
    private let savePath = URL.documentsDirectory.appending(path: "SavedPath")
    
    init() {
        if let data = try? Data(contentsOf: savePath) {
            if let decoded = try? JSONDecoder().decode(NavigationPath.CodableRepresentation.self, from: data) {
                path = NavigationPath(decoded)
                return
            }
        }
        
        path = NavigationPath()
    }
    
    func save() {
        guard let representation = path.codable else { return }
        
        do {
            let data = try JSONEncoder().encode(representation)
            try data.write(to: savePath)
        } catch {
            print("Failed to save navigation data")
        }
    }
}


struct ContentView: View {
//    @State private var path: [Int] = []
//    @State private var path = NavigationPath()
    @State private var pathStore = PathStore()
    
    var body: some View {
        NavigationStack(path: $pathStore.path) {
            DetailView(number: 0, path: $pathStore.path)
                .navigationDestination(for: Int.self) { i in
                    DetailView(number: i, path: $pathStore.path)
                }
        }
        /*NavigationStack(path: $path) {
            List {
                ForEach(0..<5) { i in
                    NavigationLink("Selected number \(i)", value: i)
                }
                
                ForEach(0..<5) { i in
                    NavigationLink("Selected String \(i)", value: String(i))
                }
            }
            .toolbar {
                Button("Push 556") {
                    path.append(556)
                }
                Button("Push Hello") {
                    path.append("Hello")
                }
            }
            .navigationDestination(for: Int.self) { selection in
                Text("You selected number: \(selection)")
            }
            .navigationDestination(for: String.self) { selection in
                Text("You selected String: \(selection)")
            }
            
            /*Button("Show 32") {
             path = [32]
             }
             
             Button("Show 64") {
             path.append(64)
             }
             
             Button("Show 32 then 64") {
             path = [32, 64]
             }*/
        }*/
    }
}

#Preview {
    ContentView()
}
