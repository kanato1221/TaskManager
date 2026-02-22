import SwiftData
import SwiftUI

struct ProjectDetailView: View {
    var project: Project
    @State private var editingSubTask: SubProjectTask?

    var body: some View {
        List {
            Section("期限: \(project.projectDate, style: .date)") {

                if project.subTask.isEmpty {
                    Text("プロジェクトが登録されていません")
                } else {
                    ForEach(project.subTask, id: \.self) { subTask in
                        HStack {
                            Image(
                                systemName: subTask.subTaskAchieved
                                    ? "checkmark.circle.fill" : "circle"
                            )
                            .foregroundColor(
                                subTask.subTaskAchieved ? .green : .gray
                            )
                            .onTapGesture {
                                subTask.subTaskAchieved.toggle()
                            }

                            VStack(alignment: .leading) {
                                Text(subTask.subTaskname)
                                    .font(.headline)
                                Text(subTask.subTaskDate, style: .date)
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }

                            Spacer()

                            Button {
                                editingSubTask = subTask
                            } label: {
                                Image(systemName: "pencil.line")
                                    .foregroundColor(.blue)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                }
            }
        }
        .navigationTitle(project.projectname)

        .sheet(item: $editingSubTask) { subTask in
            EditSubTaskSheet(subTask: subTask)
        }
    }
}
struct EditSubTaskSheet: View {
    @Environment(\.dismiss) private var dismiss
    @Bindable var subTask: SubProjectTask

    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("アクションの編集")) {
                    TextField("名前", text: $subTask.subTaskname)
                    DatePicker("期限", selection: $subTask.subTaskDate, displayedComponents: .date)
                }
            }
            .navigationTitle("編集")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("完了") { dismiss() }
                }
            }
        }
    }
}

extension SubProjectTask: Identifiable {}
#Preview {
    let container = try! ModelContainer(
        for: Project.self,
        configurations: ModelConfiguration(isStoredInMemoryOnly: true)
    )
    let project = Project(
        projectname: "test",
        projectDate: Date(),
        projectDescription: "test",
        projectKind: "test",
        projectAchieved: false,
        subTask: []
    )

    return NavigationStack {
        ProjectDetailView(project: project)
    }
    .modelContainer(container)
}
