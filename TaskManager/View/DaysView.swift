////
////  DaysView.swift
////  TaskManager
////
////  Created by 松井奏人 on 2026/02/08.
////
//
//import SwiftUI
//
//struct DaysView: View {
//    @EnvironmentObject private var calendarViewModel: CalendarViewModel
//    @Binding var selectedDate: Date?
//    let cellHeight: CGFloat
//    let allTasks: [SubProjectTask]
//    let days: [Date]
//    
//    var body: some View {
//        ForEach(days, id: \.self) { date in
//            
//            // 比率を計算する
//            let getTaskForData = calendarViewModel.getTaskForDate(date: date, allTasks: allTasks)
//            let getTaskAchieved = calendarViewModel.getTaskAchieved(tasks: getTaskForData)
//            
//            let ratio = calendarViewModel.ratio(task: getTaskForData.count, achieved: getTaskAchieved.count)
//            
//            CalendarCell(currentDate: date, cellColor: Color(red: 0, green: CGFloat(ratio/255), blue: 0, alpha: 1.0)) {
//                print("Selected: \(date.dayNumber)")
//                selectedDate = date
//            }
//            .frame(height: abs(cellHeight))
//        }
//    }
//}
