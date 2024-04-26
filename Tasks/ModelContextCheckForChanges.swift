//
//  ModelContextCheckForChanges.swift
//  Tasks
//
//  Created by Tim Mitra on 2024-04-26.
//

import SwiftUI
import SwiftData

struct ModelContextCheckForChanges: View {
  @Environment(\.modelContext) private var modelContext
    @Query(sort: [SortDescriptor(\TaskModel.completedDate),
                  SortDescriptor(\TaskModel.priority)]) private var tasks: [TaskModel]
    @State private var newTask = false
    
    var body: some View {
      NavigationStack {
        List {
          ForEach (tasks) { task in
            NavigationLink {
              AddUpdateTaskView(task: task)
            } label: {
              TaskRowView(task: task)
            }
          }
          .onDelete { indexSet in
            for index in indexSet {
              modelContext.delete(tasks[index])
            }
          }
          Section("Status") {
            LabeledContent("Has Changes", value: "\(modelContext.hasChanges)")
            LabeledContent("Deleted", value: "\(modelContext.deletedModelsArray.count)")
            LabeledContent("Inserted", value: "\(modelContext.insertedModelsArray.count)")
            LabeledContent("Changes", value: "\(modelContext.changedModelsArray.count)")
            Button("Save") {
              try? modelContext.save()
            }
            .buttonStyle(.borderedProminent)
            .disabled(modelContext.hasChanges == false)
            .frame(maxWidth: .infinity)
          }
          .font(.title)
        }
        .navigationTitle("Task Changes")
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

#Preview {
  let container = TaskModel.preview
  container.mainContext.autosaveEnabled = false
  // mock data falsely see changes, call save to fix
  try? container.mainContext.save()
  
  return  ModelContextCheckForChanges()
    .modelContainer(container)
}
