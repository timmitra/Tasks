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
          .onDelete(perform: deleteTask)
        }
        .font(.title)
    }
  private func deleteTask(indexSet: IndexSet) {
    for index in indexSet {
      modelContext.delete(tasks[index])
    }
  }
}

//#Preview {
//    TaskView()
//    .modelContainer(TaskModel.preview)
//}

#Preview("Task Incomplete") {
  let container = try! ModelContainer(for: TaskModel.self,
  configurations: ModelConfiguration(isStoredInMemoryOnly: true))
  
  return List {
    TaskRowView(task: TaskModel(taskName: "Priority 1", priority: 1))
    TaskRowView(task: TaskModel(taskName: "Priority 2", priority: 2))
    TaskRowView(task: TaskModel(taskName: "Priority 3", priority: 3))
  }
}
