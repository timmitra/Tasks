//
//  ModelContainerAutosave.swift
//  Tasks
//
//  Created by Tim Mitra on 2024-04-26.
//

import SwiftUI
import SwiftData

struct ModelContextAutosave: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    ModelContextAutosave()
    .modelContainer(for: TaskModel.self, isUndoEnabled: true)
}

#Preview("On ModelContext") {
  let container = try! ModelContainer(for: Schema([TaskModel.self]))
  container.mainContext.autosaveEnabled = false
  
  return ModelContextAutosave()
    .modelContainer(container)
}
