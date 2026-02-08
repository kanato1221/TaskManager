import SwiftUI
import SwiftData

struct CalendarContentView: View {
    @EnvironmentObject private var calendarViewModel: CalendarViewModel
    let date = Date()
    
    var body: some View {
        CalendarView()

    }
}

//#Preview {
//    let calendarViewModel = CalendarViewModel()
//    
//    ContentView()
//        .environmentObject(calendarViewModel)
//}
