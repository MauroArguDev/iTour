//
//  iTourApp.swift
//  iTour
//
//  Created by Mauricio Argumedo on 30/8/24.
//

import SwiftData
import SwiftUI

@main
struct iTourApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Destination.self)
    }
}
