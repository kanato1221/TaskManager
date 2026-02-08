import Combine
import Foundation
import SwiftUI

@MainActor
class CalendarViewModel: ObservableObject {
    
    let weekDays = ["日", "月", "火", "水", "木", "金", "土"]
    
    @Published var displayedDate = Date()
    
    @Published var currentMonthIndex: Int = 0
    
    var months: [Date] = []
    
    
    var todayDateString: String {
        displayedDate.currentDay
    }
    
    var currentMonthName: String {
        displayedDate.currentMonth
    }
    
    var currentYear: String {
        displayedDate.currentYear
    }
    
    var numberOfWeeks: Int {
        return 6
    }
    
    init() {
        generateMonthRange()
        
    }
    
    private func generateMonthRange() {
        let calendar = Calendar.current
        let now = Date()
        let totalMonths = 12 * 6
        
        months = (-totalMonths...totalMonths).compactMap { offset in
            calendar.date(byAdding: .month, value: offset, to: now)
        }
        
        currentMonthIndex = totalMonths
        displayedDate = months[currentMonthIndex]
    }
    
    func updateDisplayedMonth() {
        guard months.indices.contains(currentMonthIndex) else { return }
        displayedDate = months[currentMonthIndex]
    }
    
    var daysInMonth: [Date] {
        let calendar = Calendar.current
        
        guard
            let monthInterval = calendar.dateInterval(
                of: .month,
                for: displayedDate
            )
        else {
            return []
        }
        
        var firstDay = monthInterval.start
        let weekday = calendar.component(.weekday, from: firstDay)
        firstDay = calendar.date(
            byAdding: .day,
            value: -(weekday - calendar.firstWeekday),
            to: firstDay
        )!
        
        var lastDay = monthInterval.end
        lastDay = calendar.date(byAdding: .day, value: -1, to: lastDay)!
        let lastWeekday = calendar.component(.weekday, from: lastDay)
        let extraDays = 7 - ((lastWeekday - calendar.firstWeekday + 7) % 7 + 1)
        lastDay = calendar.date(byAdding: .day, value: extraDays, to: lastDay)!
        
        var days: [Date] = []
        var current = firstDay
        while current <= lastDay {
            days.append(current)
            current = calendar.date(byAdding: .day, value: 1, to: current)!
        }
        return days
    }
    
    func days(for month: Date) -> [Date] {
        let calendar = Calendar.current
        guard let monthInterval = calendar.dateInterval(of: .month, for: month)
        else {
            return []
        }
        
        var firstDay = monthInterval.start
        let weekday = calendar.component(.weekday, from: firstDay)
        firstDay = calendar.date(
            byAdding: .day,
            value: -(weekday - calendar.firstWeekday),
            to: firstDay
        )!
        
        var lastDay = monthInterval.end
        lastDay = calendar.date(byAdding: .day, value: -1, to: lastDay)!
        let lastWeekday = calendar.component(.weekday, from: lastDay)
        let extraDays = 7 - ((lastWeekday - calendar.firstWeekday + 7) % 7 + 1)
        lastDay = calendar.date(byAdding: .day, value: extraDays, to: lastDay)!
        
        var days: [Date] = []
        var current = firstDay
        while current <= lastDay {
            days.append(current)
            current = calendar.date(byAdding: .day, value: 1, to: current)!
        }
        return days
    }
    
    func goToNextMonth() {
        if let nextMonth = Calendar.current.date(
            byAdding: .month,
            value: 1,
            to: displayedDate
        ) {
            displayedDate = nextMonth
        }
    }
    
    func goToPreviousMonth() {
        if let previousMonth = Calendar.current.date(
            byAdding: .month,
            value: -1,
            to: displayedDate
        ) {
            displayedDate = previousMonth
        }
    }
    
    func getTaskForDate(date : Date , allTasks :[SubProjectTask]) -> [SubProjectTask]{
        allTasks.filter {
            Calendar.current.isDate($0.subTaskDate, inSameDayAs: date)
        }
    }
    func getTaskAchieved(tasks :[SubProjectTask]) -> [SubProjectTask]{
        tasks.filter{
            $0.subTaskAchieved == true
        }
    }
    func ratio (task: Int, achieved : Int) -> Double{
        guard task != 0 else {return 0}
        return Double(achieved) / Double(task)
    }
}
