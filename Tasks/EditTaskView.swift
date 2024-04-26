//
//  EditTaskView.swift
//  Tasks
//
//  Created by Tim Mitra on 2024-04-26.
//

import SwiftUI

struct EditTaskView: View {
  let task: TaskModel!
  @Environment(\.dismiss) var dismiss
  @State private var taskName: String = ""
  @State private var priority = 0
  @State private var dueDate = Date()
  @State private var hasDueDate = false
  
    var body: some View {
      Form {
        Label(
          title: { TextField("task", text: $taskName) },
          icon: { Image(systemName: "pencil.circle.fill") }
)
        VStack(alignment: .leading) {
          Label("Priority", systemImage: "diamond.circle.fill")
          Picker("", selection: $priority) {
            Text("1").tag(1)
            Text("2").tag(2)
            Text("3").tag(3)
          }
          .pickerStyle(.segmented)
        }
        Toggle("Due Date", systemImage: "calendar", isOn: $hasDueDate)
        if hasDueDate {
          DatePicker("", selection: $dueDate)
            .datePickerStyle(.graphical)
        }
        Button("Save") {
          task.taskName = taskName
          task.priority = priority
          task.dueDate = hasDueDate ? dueDate : nil
          dismiss()
        }
        .frame(maxWidth: .infinity)
        .buttonStyle(.borderedProminent)
      }
      .task {
        taskName = task.viewTaskName
        priority = task.priority
        hasDueDate = task.dueDate != nil
        dueDate = task.dueDate ?? Date()
      }
        
    }
}

#Preview("Edit Task") {
  let _ = TaskModel.preview
  let task = TaskModel(taskName: "Do something", priority: 1)
  
  return NavigationStack {
    EditTaskView(task: task)
  }
}
