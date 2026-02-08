import SwiftUI

struct CalendarCell: View {
    @EnvironmentObject private var calendarViewModel: CalendarViewModel
    let currentDate: Date
    
    let cellColor: Color
    
    let action: () -> ()

    
    var body: some View {
        RoundedRectangle(cornerRadius: 9)
            .foregroundStyle(cellColor)
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
    CalendarCell(currentDate: today, cellColor: .red) {
        print("Clicked")
    }
}
