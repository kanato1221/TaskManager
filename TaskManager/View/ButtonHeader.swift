//
//  ButtonHeader.swift
//  TaskManager
//
//  Created by 松井奏人 on 2026/02/08.
//

import SwiftUI

struct ButtonHeader: View {
    @EnvironmentObject private var calendarViewModel: CalendarViewModel
    var body: some View {
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
    }
    
    
}
#Preview {
    ButtonHeader()
}
