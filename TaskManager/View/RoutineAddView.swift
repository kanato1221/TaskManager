import SwiftUI
import SwiftData

struct RoutineAddView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    @State private var routineName: String = ""
    @State private var startDate: Date = Date()
    @State private var endDate: Date = Calendar.current.date(byAdding: .month, value: 1, to: Date()) ?? Date()
    
    // 💡 無期限スイッチの状態
    @State private var isIndefinite: Bool = true
    
    var body: some View {
        NavigationStack {
            Form {
                Section("何を毎日やりますか？") {
                    TextField("例：7時に起きる", text: $routineName)
                }
                
                Section("期間の設定") {
                    DatePicker("開始日", selection: $startDate, displayedComponents: .date)
                    
                    // 💡 無期限スイッチ
                    Toggle("無期限", isOn: $isIndefinite)
                    
                    // 💡 無期限じゃない時だけ終了日を表示
                    if !isIndefinite {
                        DatePicker("終了日", selection: $endDate, displayedComponents: .date)
                    }
                }
                
                Button(action: saveRoutine) {
                    Text("日課として登録")
                        .frame(maxWidth: .infinity)
                        .fontWeight(.bold)
                }
                .buttonStyle(.borderedProminent)
                .disabled(routineName.isEmpty)
            }
            .navigationTitle("新しい日課")
        }
    }

    func saveRoutine() {
        let calendar = Calendar.current
        
        // 💡 無期限なら「今日から1年後」を終了日に設定する
        let finalEndDate: Date
        if isIndefinite {
            finalEndDate = calendar.date(byAdding: .year, value: 1, to: startDate) ?? endDate
        } else {
            finalEndDate = endDate
        }

        let routineProject = Project(
            projectname: "日課: \(routineName)",
            projectDate: finalEndDate,
            projectDescription: "Daily Routine",
            projectKind: "Routine",
            projectAchieved: false,
            subTask: []
        )

        var currentDate = startDate
        
        // 終了日までループして生成
        while currentDate <= finalEndDate {
            let task = SubProjectTask(
                subTaskname: routineName,
                subTaskDate: currentDate,
                subTaskDescription: "Routine",
                subTaskKind: "",
                subTaskAchieved: false
            )
            routineProject.subTask.append(task)
            
            guard let nextDate = calendar.date(byAdding: .day, value: 1, to: currentDate) else { break }
            currentDate = nextDate
        }
        
        modelContext.insert(routineProject)
        dismiss()
    }
}
#Preview {
    RoutineAddView()
}
