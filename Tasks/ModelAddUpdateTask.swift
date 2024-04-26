//
//  ModelAddUpdateTask.swift
//  Tasks
//
//  Created by Tim Mitra on 2024-04-26.
//

import SwiftUI
import SwiftData

struct ModelAddUpdateTask: View {
  @Query(sort: [SortDescriptor(\TaskModel.completedDate),
                SortDescriptor(\TaskModel.priority)]) private var tasks: [TaskModel]
  @State private var newTask = false
  
    var body: some View {
      NavigationStack {
        List(tasks) { task in
          NavigationLink {
            AddUpdateTaskView(task: task)
          } label: {
            TaskRowView(task: task)
          }
        }
        .navigationTitle("Tasks")
        .toolbar {
          NavigationLink {
            AddUpdateTaskView()
          } label: {
            Image(systemName: "plus")
          }
        }
        .sheet(isPresented: $newTask) {
          InsertTaskView()
        }
      }
    }
}

#Preview("Main View") {
    ModelAddUpdateTask()
    .modelContainer(TaskModel.preview)
}
