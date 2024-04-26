//
//  AddUpdateTaskView.swift
//  Tasks
//
//  Created by Tim Mitra on 2024-04-26.
//

import SwiftUI

struct AddUpdateTaskView: View {
  var task: TaskModel? = nil
  @Environment(\.modelContext) private var modelContext
  @Environment(\.dismiss) var dismiss
  @State private var taskName: String = ""
  @State private var priority = 0
  @State private var dueDate = Date()
  @State private var hasDueDate = false
  
  var newTask: Bool {
    task == nil ? true : false
  }
  
  var body: some View {
    Form {
      Label(
        title: { TextField("task", text: $taskName) },
        icon: { Image(systemName: "pencil.circle.fill") })
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
      Button(newTask ? "Add" : "Update") {
        // both get values from the States
        if newTask {
          let task = TaskModel(taskName: taskName, priority: priority)
          task.dueDate = hasDueDate ? dueDate : nil
        } else {
          task?.taskName = taskName
          task?.priority = priority
          task?.dueDate = dueDate
        }
        dismiss()
      }
      .frame(maxWidth: .infinity)
      .buttonStyle(.borderedProminent)
    }
    .task {
      if let task {
        taskName = task.viewTaskName
        priority = task.priority
        hasDueDate = task.dueDate != nil
        dueDate = task.dueDate ?? Date()
      }
    }
    .navigationTitle(newTask ? "Add Task" : "Update Task")
  }
}


#Preview {
    AddUpdateTaskView()
}
