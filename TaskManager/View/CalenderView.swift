//
//  CalenderView.swift
//  TaskManager
//
//  Created by 松井奏人 on 2025/12/14.
//

import SwiftUI

struct CalenderView: View {
    var body: some View {
        NavigationStack{
            VStack {
                
            }
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    
                    NavigationLink{
                        AddTaskView()
                    }label:{
                        Text("目標一覧")
                    }
                }
            }
        }
    }
    
}

#Preview {
    CalenderView()
}
