import SwiftUI

struct CalendarCell: View {
    @EnvironmentObject private var calendarViewModel: CalendarViewModel
    let currentDate: Date
    
    let action: () -> ()

    
    var body: some View {
        RoundedRectangle(cornerRadius: 9)
            .foregroundStyle(.regularMaterial)
            .contentShape(Rectangle())
            .overlay(content: {
                VStack {
                    HStack {
                        Text("\(currentDate.dayNumber)")
                        Spacer()
                    }
                    Spacer()
                }
                .padding(CGFloat(3))
            })
            .onTapGesture {
                action()
            }
    }
}

#Preview {
    let today = Date()
    CalendarCell(currentDate: today) {
        print("Clicked")
    }
}
