//
//  ContentView.swift
//  iTour
//
//  Created by Mauricio Argumedo on 30/8/24.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    // MARK: - Properties
    @Environment(\.modelContext) var modelContext
    @Query var destinations: [Destination]
    
    // MARK: - Body
    var body: some View {
        NavigationStack {
            List {
                ForEach(destinations) { destination in
                    VStack(alignment: .leading) {
                        Text(destination.name)
                            .font(.headline)
                        
                        Text(destination.date.formatted(date: .long, time: .shortened))
                    }
                }
            }
            .navigationTitle("iTour")
            .toolbar {
                Button("Add Samples", action: addSamples)
            }
        }
    }
    
    func addSamples() {
        let rome = Destination(name: "Rome")
        let florence = Destination(name: "Florence")
        let naples = Destination(name: "Naples")
        modelContext.insert(rome)
        modelContext.insert(florence)
        modelContext.insert(naples)
    }
}

// MARK: - Preview
#Preview {
    ContentView()
}
