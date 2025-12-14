//
//  TaskManagerView.swift
//  TaskManager
//
//  Created by 松井奏人 on 2025/12/14.
//

import SwiftUI

struct TaskManagerView: View {
    var body: some View {
        TextField("最終目標", text: $project )
        TextFieldStyle(.roundedBorder())
    }
}

#Preview {
    TaskManagerView()
}
