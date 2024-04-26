//
//  TaskModel.swift
//  Tasks
//
//  Created by Tim Mitra on 2024-04-26.
//

import Foundation
import SwiftData
import SwiftUI

@Model
class TaskModel {
  var taskName: String
  var completedDate: Date?
  var priority: Int
  var dueDate: Date?
  
  init(taskName: String, priority: Int = 2) {
    self.taskName = taskName
    self.priority = priority
  }
}

extension TaskModel {
  var viewTaskName: String {
    taskName.isEmpty ? "[Enter Task Name]" : taskName
  }
  var isComplete: Bool {
    completedDate == nil ? false : true
  }
  var viewPriority: String {
    "\(priority).circle.fill"
  }
  var viewDueDate: String {
    dueDate?.formatted(date: .numeric, time: .omitted) ?? ""
  }
  var viewPriorityColor: Color {
    if completedDate != nil {
      return .gray
    } else if priority == 1 {
      return .green
    } else if priority == 2 {
      return .orange
    }
    return .red
  }
}

extension TaskModel {
  @MainActor
  static var preview: ModelContainer {
    let container = try! ModelContainer(for: TaskModel.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MM-dd-yyyy"
    
    container.mainContext.insert(TaskModel(taskName: "Get gift for anniversary", priority: 3))
    container.mainContext.insert(TaskModel(taskName: "Prepare for sale", priority: 2))
    
    let taskWithDueDate = TaskModel(taskName: "Marketing Meeting", priority: 1)
    taskWithDueDate.dueDate = dateFormatter.date(from: "2-10-2025")!
    container.mainContext.insert(taskWithDueDate)
    
    let completedTask = TaskModel(taskName: "Get Milk", priority: 1)
    completedTask.completedDate = Date.now
    container.mainContext.insert(completedTask)

    
    return container
  }
}
