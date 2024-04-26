//
//  TasksApp.swift
//  Tasks
//
//  Created by Tim Mitra on 2024-04-26.
//

import SwiftUI
import SwiftData

@main
struct TasksApp: App {
    var body: some Scene {
        WindowGroup {
            ModelContextAutosave()
            //.modelContainer(for: TaskModel.self, isAutosaveEnabled: false)
            .modelContainer(container)
        }
    }
  
  @MainActor
  var container: ModelContainer {
    //let schema = Schema([TaskModel.self])
    //let container = try! ModelContainer(for: schema)
    let container = TaskModel.preview
    container.mainContext.autosaveEnabled = false
    container.mainContext.undoManager = UndoManager()
    
    return container
  }
}
