import SwiftData
import SwiftUI

struct SubTask: Identifiable {
    let id = UUID()
    var title: String
    var date: Date
    var isRoutine: Bool = false
}

struct TaskManagerView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext
    @State private var taskTitle: String = ""
    @State private var deadline: Date = Date()
    @State private var subTaskTitle: String = ""
    @State private var subTasks: [SubTask] = []
    @State private var subTaskDate: Date = Date()
    @State private var isRoutine: Bool = false

    var body: some View {

        NavigationStack {

            Form {
                Section(header: Text("最終目標")) {
                    TextField("目標", text: $taskTitle)

                    DatePicker(
                        "期限",
                        selection: $deadline,
                        displayedComponents: .date
                    )

                }
                Section(header: Text("具体的なアクション")) {
                    HStack {
                        TextField("アクション", text: $subTaskTitle)
                            .textFieldStyle(.roundedBorder)
                        DatePicker(
                            "",
                            selection: $subTaskDate,
                            displayedComponents: .date
                        )
                        Button{

                            if !subTaskTitle.isEmpty {
                                let newTask = SubTask(
                                    title: subTaskTitle,
                                    date: subTaskDate,
                                    isRoutine: isRoutine
                                )
                                subTasks.append(newTask)
                                subTaskTitle = ""

                            }
                        }label: {

                            Image(systemName: "plus")
                        }
                    }
                    
                    Toggle("毎日繰り返す", isOn: $isRoutine)
                        .font(.caption)
                        .padding(5)

                    ForEach(subTasks) { task in
                        HStack {
                            Text(task.title)
                            if task.isRoutine {
                                Image(systemName: "repeat") // ルーティンマーク
                                                    .font(.caption)
                                                    .foregroundColor(.blue)
                            }
                            Spacer()
                            Text(task.date, style: .date)
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                    }
                    .onDelete { indexSet in
                        subTasks.remove(atOffsets: indexSet)
                    }
                    Section {
                        Button("保存") {
                            save()
                        }
                    }
                }
            }

        }
        .navigationTitle("目標の追加")
        
    }

    func save() {
        print("目標: \(taskTitle)")

        let newProject = Project(
            projectname: taskTitle,
            projectDate: deadline,
            projectDescription: "",
            projectKind: "",
            projectAchieved: false,
            subTask: []
        )
        
        for item in subTasks{
            let newSubProjectTask = SubProjectTask(
                subTaskname: item.title,
                subTaskDate: item.date,
                subTaskDescription: "",
                subTaskKind: "",
                subTaskAchieved: false
            )
            newProject.subTask.append(newSubProjectTask)
        }
       
        modelContext.insert(newProject)
        dismiss()
    }
}
#Preview {
    TaskManagerView()
}
