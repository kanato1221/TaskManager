import SwiftUI

struct WeekdayHeader: View {
    @EnvironmentObject private var calendarViewModel: CalendarViewModel
    
    var body: some View {
        LazyVGrid(
            columns: Array(
                repeating: GridItem(.flexible(), spacing: 4),
                count: 7
            ),
            spacing: 8
        ) {
            ForEach(calendarViewModel.weekDays, id: \.self) { day in
                Text(day)
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.secondary)
            }
        }
        .padding(.horizontal)
    }
}

