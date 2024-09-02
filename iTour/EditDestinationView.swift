//
//  EditDestinationView.swift
//  iTour
//
//  Created by Mauricio Argumedo on 30/8/24.
//

import SwiftData
import SwiftUI

struct EditDestinationView: View {
    // MARK: - Properties
    @Environment(\.modelContext) var modelContext
    @Bindable var destination: Destination
    @State private var newSightName = ""
    
    // MARK: - Body
    var body: some View {
        Form {
            TextField("Name", text: $destination.name)
            TextField("Details", text: $destination.details, axis: .vertical)
            DatePicker("Date", selection: $destination.date)
            
            Section("Priority") {
                Picker("Priority", selection: $destination.priority) {
                    Text("Meh").tag(1)
                    Text("Maybe").tag(2)
                    Text("Must").tag(3)
                }.pickerStyle(.segmented)
            }
            
            Section("Sights") {
                ForEach(destination.sights) { sight in
                    Text(sight.name)
                }.onDelete(perform: deleteDestinations)
                
                HStack {
                    TextField("Add a new sight in \(destination.name)", text: $newSightName)
                    
                    Button("Add", action: addSight)
                }
            }
        }
        .navigationTitle("Edit Destination")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    func addSight() {
        guard newSightName.isEmpty == false else { return }
        
        withAnimation {
            let sight = Sight(name: newSightName)
            destination.sights.append(sight)
            newSightName = ""
        }
    }
    
    func deleteDestinations(_ indexSet: IndexSet) {
        for index in indexSet {
            let sight = destination.sights[index]
            modelContext.delete(sight)
        }
    }
}

// MARK: - Preview
#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Destination.self, configurations: config)
        let example = Destination(name: "Example Destination", details: "Example details fo here and will automatically expand vertically as ther are edited.")
        return EditDestinationView(destination: example)
            .modelContainer(container)
    } catch {
        fatalError("Failed to create model container")
    }
}
