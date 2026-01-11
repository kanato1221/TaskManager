import Foundation
import SwiftData

@Model
class Task {
    var taskName: String
    var taskDate: Date
    var taskDescription: String
    var taskKind: String
    var taskAchieved: Bool
    
    init(
        taskName: String,
        taskDate: Date,
        taskDescription: String,
        taskKind: String,
        taskAchieved: Bool
    ) {
        self.taskName = taskName
        self.taskDate = taskDate
        self.taskDescription = taskDescription
        self.taskKind = taskKind
        self.taskAchieved = taskAchieved
    }
}
@Model
final class SubProjectTask {
    var subTaskname: String
    var subTaskDate: Date
    var subTaskDescription: String
    var subTaskKind: String
    var subTaskAchieved: Bool
    var project: Project?
    
    init(
        subTaskname: String,
        subTaskDate: Date,
        subTaskDescription: String,
        subTaskKind: String,
        subTaskAchieved: Bool,
        project: Project? = nil
    ) {
        self.subTaskname = subTaskname
        self.subTaskDate = subTaskDate
        self.subTaskDescription = subTaskDescription
        self.subTaskKind = subTaskKind
        self.subTaskAchieved = subTaskAchieved
    }
}

@Model
final class Project {
    var projectname: String
    var projectDate: Date
    var projectDescription: String
    var projectKind: String
    var projectAchieved: Bool
    
    @Relationship(deleteRule: .cascade, inverse: \SubProjectTask.project)
    var subTask: [SubProjectTask] = []
    
    init(
        projectname: String,
        projectDate: Date,
        projectDescription: String,
        projectKind: String,
        projectAchieved: Bool,
        subTask: [SubProjectTask]
    ) {
        
        self.projectname = projectname
        self.projectDate = projectDate
        self.projectDescription = projectDescription
        self.projectKind = projectKind
        self.projectAchieved = projectAchieved
        self.subTask = subTask
    }
}
