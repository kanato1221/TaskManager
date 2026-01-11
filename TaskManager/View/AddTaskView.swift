//
//  AddTaskView.swift
//  TaskManager
//
//  Created by 松井奏人 on 2025/12/14.
//

import SwiftUI
import SwiftData

struct AddTaskView: View {
    
    @Query var projects: [Project]
    var body: some View {
        VStack {
            if projects.isEmpty {
                Text("プロジェクトがありません")
            }else{
                
                ForEach(projects, id: \.self){ project in
                    Text(project.projectname)
                }
                
            }
        }
        
        .toolbar{
            ToolbarItem(placement: .primaryAction){
                NavigationLink{
                    TaskManagerView()
                }label:{
                    Text("目標の追加")
                }
            }
        }
        
    }
}

#Preview {
    AddTaskView()
}
