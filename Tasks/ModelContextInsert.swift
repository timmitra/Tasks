//
//  ModelContextInsert.swift
//  Tasks
//
//  Created by Tim Mitra on 2024-04-26.
//

import SwiftUI
import SwiftData

struct ModelContextInsert: View {
  @Query(sort: [SortDescriptor(\TaskModel.completedDate),
                SortDescriptor(\TaskModel.priority)]) private var tasks: [TaskModel]
  @State private var newTask = false
  
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
      .toolbar {
        Button {
          newTask.toggle()
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

#Preview {
    ModelContextInsert()
    .modelContainer(TaskModel.preview)
}
