import SwiftUI
import SwiftData


struct ProjectDetailView: View {
    var project: Project
    
    var body: some View {
        List{
            Section(header: Text("期限: \(project.projectDate, style: .date)")){
                if project.subTask.isEmpty{
                    Text("プロジェクトが登録されていません")
                }else{
                    ForEach(project.subTask){
                        subTask in
                        HStack{
                            Image(systemName: subTask.subTaskAchieved ? "checkmark.circle.fill" : "circle")
                                .foregroundColor(subTask.subTaskAchieved ? .green : .gray)
                            VStack(alignment: .leading){
                                Text(subTask.subTaskname)
                                Text(subTask.subTaskDate, style: .date)
                            }
                            .onTapGesture {
                                subTask.subTaskAchieved.toggle()
                            }
                        }
                        
                    }
                }
                
            }
        }
        .navigationTitle(project.projectname)
        
    }
}

#Preview {
    let project = Project(projectname: "test", projectDate: Date(), projectDescription: "test", projectKind: "test", projectAchieved: false, subTask: [])
    ProjectDetailView(project: project)
}
