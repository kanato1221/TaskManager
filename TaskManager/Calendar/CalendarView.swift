import SwiftData
import SwiftUI

struct CalendarView: View {
    @EnvironmentObject private var calendarViewModel: CalendarViewModel
    @State private var selectedDate: Date?
    @Query private var allTasks: [SubProjectTask]

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // MARK: - Button Header
                

                VStack(spacing: 16) {
                    
                    ButtonHeader()
                        .padding(.horizontal)
                    
                    VStack {

                        // MARK: - Weekday Header
                        WeekdayHeader()
                    }

                    // MARK: - Calendar Grid
                    CalendarGrid()
                }
            }

        }
    }
}

#Preview {
    let calendarViewModel = CalendarViewModel()
    CalendarView()

        .environmentObject(calendarViewModel)
}
