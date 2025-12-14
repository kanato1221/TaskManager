//
//  AddTaskView.swift
//  TaskManager
//
//  Created by 松井奏人 on 2025/12/14.
//

import SwiftUI

struct AddTaskView: View {
    var body: some View {
        VStack {
            Text("a")
            
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
