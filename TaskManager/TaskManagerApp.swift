//
//  TaskManagerApp.swift
//  TaskManager
//
//  Created by 松井奏人 on 2025/12/14.
//

import SwiftUI

@main
struct YourProjectNameApp: App {
    @StateObject private var calendarViewModel = CalendarViewModel()

    var body: some Scene {
        WindowGroup {
            CalendarView()
                .environmentObject(calendarViewModel)
                .modelContainer(for: [Task.self, SubProjectTask.self, Project.self])
        }
    }
}
