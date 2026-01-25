//
//  AddTaskView.swift
//  TaskManager
//
//  Created by 松井奏人 on 2025/12/14.
//

import SwiftData
import SwiftUI

struct AddTaskView: View {
    @Environment(\.modelContext) private var modelContext
    @Query var projects: [Project]
    var body: some View {
        VStack {
            
            if projects.isEmpty {
                Text("プロジェクトがありません")
            } else {
                List{
                    ForEach(projects){
                        project in
                        NavigationLink(destination: ProjectDetailView(project: project)){
                        VStack(alignment: .leading){
                            Text(project.projectname)
                                .font(.headline)
                            Text("期限: \(project.projectDate, style: .date)")
                                .font(.caption)
                        }
                    }
                    
                        .listRowBackground(Color.gray.opacity(0.2))
                    }
                    .onDelete(perform: deleteProject)
                }.scrollContentBackground(.hidden)
                    .background(Color.white)
            }
        }
        .navigationTitle("目標一覧")
.toolbar {
    ToolbarItem(placement: .primaryAction) {
        NavigationLink {
            TaskManagerView()
        } label: {
            Image(systemName: "plus")
        }
    }
}
        
    }
    func deleteProject(offsets: IndexSet){
        for index in offsets {
            modelContext.delete(projects[index])
        }
    }
}


#Preview {
    AddTaskView()
}
