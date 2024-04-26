//
//  ContentView.swift
//  Tasks
//
//  Created by Tim Mitra on 2024-04-26.
//

import SwiftUI
import SwiftData

struct TaskView: View {
  @Environment(\.modelContext) private var modelContext
  @Query<TaskModel>(sort: [SortDescriptor(\.completedDate),
                           SortDescriptor(\.priority)])
  private var tasks: [TaskModel]
  
  var body: some View {
    List {
      ForEach(tasks) { task in
        TaskRowView(task: task)
      }
    }
    Button("Delete Completed", systemImage: "trash") {
      let predicate = #Predicate<TaskModel> {
        task in
        task.completedDate != nil
      }
      try? modelContext.delete(model: TaskModel.self, where: predicate)
    }
  }
}

#Preview {
    TaskView()
    .modelContainer(TaskModel.preview)
}

//#Preview("Task Incomplete") {
//  let container = try! ModelContainer(for: TaskModel.self,
//  configurations: ModelConfiguration(isStoredInMemoryOnly: true))
//  
//  return List {
//    TaskRowView(task: TaskModel(taskName: "Priority 1", priority: 1))
//    TaskRowView(task: TaskModel(taskName: "Priority 2", priority: 2))
//    TaskRowView(task: TaskModel(taskName: "Priority 3", priority: 3))
//  }
//}
