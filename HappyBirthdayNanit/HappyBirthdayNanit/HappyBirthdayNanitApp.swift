//
//  HappyBirthdayNanitApp.swift
//  HappyBirthdayNanit
//
//  Created by Shauli Algawi on 15/02/2024.
//

import SwiftUI
import SwiftData

@main
struct HappyBirthdayNanitApp: App {
    let modelContainer: ModelContainer
    
    init() {
        do {
            modelContainer = try ModelContainer(for: ChildItem.self)
        } catch {
            fatalError("Could not initialize ModelContainer")
        }
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(modelContainer)
        }
    }
}
