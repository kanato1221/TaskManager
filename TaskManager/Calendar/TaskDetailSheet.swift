import SwiftData
import SwiftUI

struct TaskDetailSheet: View {
    let date: Date
    @Query private var allSubTasks: [SubProjectTask]
    private var todaysTasks: [SubProjectTask] {
        allSubTasks.filter {
            Calendar.current.isDate($0.subTaskDate, inSameDayAs: date)
        }
    }

    var body: some View {
        NavigationStack {
            List {
                if todaysTasks.isEmpty {
                    ContentUnavailableView(
                        "予定はありません",
                        systemImage: "calendar.badge.checkmark",
                        description: Text(
                            "\(date.formatted(date: .long, time: .omitted))"
                        )
                    )
                } else {
                    Section(
                        header: Text(
                            "\(date.formatted(date: .long, time: .omitted))"
                        )
                    ) {
                        ForEach(todaysTasks) { task in
                            HStack {
                                Image(
                                    systemName: task.subTaskAchieved
                                        ? "checkmark.circle.fill" : "circle"
                                )
                                .foregroundColor(
                                    task.subTaskAchieved ? .green : .gray
                                )

                                Text(task.subTaskname)
                                    .font(.headline)
                                    .strikethrough(task.subTaskAchieved)

                                if !task.subTaskDescription.isEmpty {
                                    Text(task.subTaskDescription)
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                }

                            }
                            .onTapGesture {
                                task.subTaskAchieved.toggle()
                                print(task.subTaskAchieved)
                            }

                            if let projectName = task.project?.projectname {
                                Text(projectName)
                                    .font(.system(size: 10))
                                    .padding(.horizontal, 6)
                                    .padding(.vertical, 2)
                                    .background(Color.blue.opacity(0.1))
                                    .cornerRadius(4)
                            }

                        }
                    }
                }
            }
        }
        .navigationTitle("今日の予定")
        .navigationBarTitleDisplayMode(.inline)
    }
}
