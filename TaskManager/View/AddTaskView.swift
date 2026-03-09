import SwiftData
import SwiftUI

struct AddTaskView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Project.projectDate) var projects: [Project]

    let date = Date()

    var body: some View {

        VStack {

            if projects.isEmpty {
                Text("プロジェクトがありません")
            } else {
                List {
                    let activeProjects = projects.filter { !$0.projectAchieved }
                    if !activeProjects.isEmpty {
                        Section("進行中") {
                            ForEach(activeProjects) { project in
                                projectRow(project: project)
                            }
                            .onDelete { indexSet in
                                deleteFromList(
                                    offsets: indexSet,
                                    filteredList: activeProjects
                                )
                            }
                        }
                    }

                    let completedProjects = projects.filter {
                        $0.projectAchieved
                    }
                    if !completedProjects.isEmpty {
                        Section("完了済み") {
                            ForEach(completedProjects) { project in
                                projectRow(project: project)
                            }
                            .onDelete { indexSet in
                                deleteFromList(
                                    offsets: indexSet,
                                    filteredList: completedProjects
                                )
                            }
                        }
                    }
                }
                .scrollContentBackground(.hidden)
                .background(Color.clear)
            }
        }
        .navigationTitle("目標一覧")
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                NavigationLink {
                    TaskManagerView()
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
    }

    @ViewBuilder
    private func projectRow(project: Project) -> some View {
        HStack {

            if project.projectDate < date {

                NavigationLink(destination: ProjectDetailView(project: project))
                {
                    VStack(alignment: .leading) {
                        Text(project.projectname)
                            .font(.headline)
                            .strikethrough(
                                project.projectAchieved,
                                color: .gray
                            )
                            .foregroundColor(
                                project.projectAchieved ? .gray : .primary
                            )

                        Text("期限: \(project.projectDate, style: .date)")
                            .font(.caption)

                            .foregroundColor(
                                project.projectAchieved
                                    ? Color(
                                        red: 1.0,
                                        green: 0.58,
                                        blue: 0.0,
                                        opacity: 1.0
                                    ) : .secondary
                            )
                    }
                }

            } else {
                NavigationLink(destination: ProjectDetailView(project: project))
                {
                    VStack(alignment: .leading) {
                        Text(project.projectname)
                            .font(.headline)
                            .strikethrough(
                                project.projectAchieved,
                                color: .gray
                            )
                            .foregroundColor(
                                project.projectAchieved ? .gray : .primary
                            )

                        Text("期限: \(project.projectDate, style: .date)")
                            .font(.caption)

                            .foregroundColor(
                                project.projectAchieved ? .gray : .secondary
                            )

                    }
                }

            }

            Spacer()

            Button {
                print(project.projectDate < date)
                withAnimation {
                    project.projectAchieved.toggle()
                }
            } label: {
                Image(
                    systemName: project.projectAchieved
                        ? "checkmark.circle.fill" : "circle"
                )
                .foregroundColor(project.projectAchieved ? .green : .blue)
                .font(.title3)
            }
            .buttonStyle(.plain)
        }
        .listRowBackground(
            project.projectAchieved
                ? Color.gray.opacity(0.1) : Color.gray.opacity(0.2)
        )
    }

    func deleteFromList(offsets: IndexSet, filteredList: [Project]) {
        for index in offsets {
            let projectToDelete = filteredList[index]
            modelContext.delete(projectToDelete)
        }
    }

}
