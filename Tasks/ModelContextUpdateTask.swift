//
//  ModelContextUpdateTask.swift
//  Tasks
//
//  Created by Tim Mitra on 2024-04-26.
//

import SwiftUI
import SwiftData

struct ModelContextUpdateTask: View {
  @Query<TaskModel>(sort: [SortDescriptor(\.completedDate),
                           SortDescriptor(\.priority)])
  private var tasks: [TaskModel]
  
    var body: some View {
      NavigationStack {
        List(tasks) { task in
          NavigationLink {
           EditTaskView(task: task)
          } label: {
            TaskRowView(task: task)
          }
        }
        .navigationTitle("Tasks")
      }
    }
}

#Preview {
    ModelContextUpdateTask()
    .modelContainer(TaskModel.preview)
}
