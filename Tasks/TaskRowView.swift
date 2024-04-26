//
//  TaskRowView.swift
//  Tasks
//
//  Created by Tim Mitra on 2024-04-26.
//

import SwiftUI

struct TaskRowView: View {
  let task: TaskModel
  
    var body: some View {
      HStack {
        VStack(alignment: .leading) {
          Text(task.viewTaskName)
            .strikethrough(task.isComplete, color: .red)
          Text(task.viewDueDate)
            .font(.body)
        }
        Spacer()
        Image(systemName: task.viewPriority)
          .foregroundStyle(task.viewPriorityColor)
      }
      .font(.title)
    }
}

#Preview("Completed Task") {
  let _ = TaskModel.preview
  let completedTask = TaskModel(taskName: "Completed Task", priority: 1)
  completedTask.dueDate = Date.now
  completedTask.completedDate = Date.now
  return TaskRowView(task: completedTask)
    .padding()
}
