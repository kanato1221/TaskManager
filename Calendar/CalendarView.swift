import SwiftData
import SwiftUI

struct CalendarView: View {
    @EnvironmentObject private var calendarViewModel: CalendarViewModel
    @State private var selectedDate: Date?

    var body: some View {
        VStack(spacing: 0) {
            // MARK: - Button Header
            VStack(spacing: 16) {
                HStack {
                    Button {
                        withAnimation(.easeInOut) {
                            if calendarViewModel.currentMonthIndex > 0 {
                                calendarViewModel.currentMonthIndex -= 1
                            }
                        }
                    } label: {
                        Image(systemName: "chevron.left")
                            .font(.title3)
                            .padding(8)
                    }
                    .buttonStyle(.plain)

                    Spacer()

                    VStack(spacing: 4) {
                        Text(calendarViewModel.currentYear)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        Text(calendarViewModel.currentMonthName)
                            .font(.title2)
                            .fontWeight(.bold)
                    }

                    Spacer()

                    Button {
                        withAnimation(.easeInOut) {
                            if calendarViewModel.currentMonthIndex
                                < calendarViewModel.months.count - 1
                            {
                                calendarViewModel.currentMonthIndex += 1
                            }
                        }
                    } label: {
                        Image(systemName: "chevron.right")
                            .font(.title3)
                            .padding(8)
                    }
                    .buttonStyle(.plain)
                }
                .padding(.horizontal)

                // MARK: - Weekday Header
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

            // MARK: - Calendar Grid
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
                                CalendarCell(currentDate: date) {
                                    print("Selected: \(date.dayNumber)")
                                    selectedDate = date
                                }
                                .frame(height: abs(cellHeight))
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
        }
        .sheet(
            isPresented: Binding<Bool>(
                get: { selectedDate != nil },
                set: { if !$0 { selectedDate = nil } }
            )
        ) {

        }
    }
}

#Preview {
    let calendarViewModel = CalendarViewModel()
    CalendarView()
        .environmentObject(calendarViewModel)
}
