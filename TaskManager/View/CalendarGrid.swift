//
//  CalendarGrid.swift
//  TaskManager
//
//  Created by 松井奏人 on 2026/02/08.
//

import SwiftUI
import SwiftData

struct CalendarGrid: View {
    
    @State private var selectedDate: Date?
    @Query private var allTasks: [SubProjectTask]
    @EnvironmentObject private var calendarViewModel: CalendarViewModel
    var body: some View {
        
        TabView(selection: $calendarViewModel.currentMonthIndex) {
            ForEach(
                Array(calendarViewModel.months.enumerated()),
                id: \.offset
            ) { index, month in
                GeometryReader { geo in
                    let height = geo.size.height * 0.97
                    let days = calendarViewModel.days(for: month)
                    let totalDays = days.count
                    let columns = 7
                    let rows = CGFloat(
                        ceil(Double(totalDays) / Double(columns))
                    )
                    let cellHeight = height / rows
                    LazyVGrid(
                        columns: Array(
                            repeating: GridItem(.flexible(), spacing: 4),
                            count: 7
                        ),
                        spacing: 4
                    ) {
                        ForEach(days, id: \.self) { date in
                            
                            dayCell(for: date, cellHeight: cellHeight)
                        }
                    }
                    .padding(.horizontal)
                }
            }
        }
        .padding(.top, 5)
        .tabViewStyle(.page(indexDisplayMode: .never))
        .animation(.easeInOut, value: calendarViewModel.currentMonthIndex)
        .onChange(of: calendarViewModel.currentMonthIndex) { _, _ in
            calendarViewModel.updateDisplayedMonth()
        }
        
        .sheet(
            isPresented: Binding<Bool>(
                get: { selectedDate != nil },
                set: { if !$0 { selectedDate = nil } }
                
            )
        ) {
            if let date = selectedDate {
                TaskDetailSheet(date:date)
                    .presentationDetents([.large])
            }
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
    
    @ViewBuilder
    private func dayCell(for date: Date, cellHeight: CGFloat) -> some View {
        let tasks = calendarViewModel.getTaskForDate(date: date, allTasks: allTasks)
        
        // 1. タスクが一個もない場合の処理
        if tasks.isEmpty {
            CalendarCell(currentDate: date, cellColor: Color(.systemGray6)) { // 薄いグレー
                selectedDate = date
            }
            .frame(height: abs(cellHeight))
        } else {
            
            // 2. タスクがある場合のグラデーション処理
            let achieved = calendarViewModel.getTaskAchieved(tasks: tasks)
            let ratio = calendarViewModel.ratio(task: tasks.count, achieved: achieved.count)
            let percentage = min(max(Double(ratio), 0), 1.0)
            
            let cellUIColor = UIColor(
                red: achieved.count == 0 ? 1.0 : 0.0,
                green: 1.0,
                blue: achieved.count == 0 ? 1.0 : 0.0,
                alpha: percentage
            )
            
            let cellColor = Color(uiColor: cellUIColor)
            
            CalendarCell(currentDate: date, cellColor: cellColor) {
                selectedDate = date
            }
            .frame(height: abs(cellHeight))
        }
    }
    
}
