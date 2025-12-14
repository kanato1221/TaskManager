import Foundation
import SwiftData

@Model
class Task {
    var taskName: String
    var taskDate: Date
    var taskDescription: String
    var taskKind: String
    var taskAchieved: Bool
    var project :String
    
    init(taskName: String, taskDate: Date, taskDescription: String, taskKind: String, taskAchieved: Bool, project:String) {
        self.taskName = taskName
        self.taskDate = taskDate
        self.taskDescription = taskDescription
        self.taskKind = taskKind
        self.taskAchieved = taskAchieved
        self.project = project
    }
    
    
}
