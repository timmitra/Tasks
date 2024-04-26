//
//  RollbackCanRedo.swift
//  Tasks
//
//  Created by Tim Mitra on 2024-04-26.
//

import SwiftUI
import SwiftData

struct RollbackCanRedo: View {
  @Environment(\.modelContext) private var modelContext
  @Query(sort: \TaskModel.completedDate) private var tasks: [TaskModel]
  
  var body: some View {
    NavigationStack {
      List {
        ForEach(tasks) { task in
          Text(task.taskName)
            .strikethrough(task.isComplete, color: .red)
        }
        .onDelete(perform: deleteTask)
      }
      .navigationTitle("Rollback")
      .toolbar {
        Button("", systemImage: "arrow.uturn.left") {
          withAnimation {
            modelContext.undoManager?.undo()
          }
        }
        .disabled(modelContext.undoManager!.canUndo == false)
        Button("", systemImage: "arrow.uturn.right") {
          withAnimation {
            modelContext.undoManager?.redo()
          }
        }
        .disabled(modelContext.undoManager!.canRedo == false)
      }
    }
    .font(.title)
  }
  private func deleteTask(indexSet: IndexSet) {
    for index in indexSet {
      modelContext.delete(tasks[index])
    }
  }
}

#Preview {
  let container = TaskModel.preview
  container.mainContext.undoManager = UndoManager()
  return RollbackCanRedo()
    .modelContainer(container)
}
