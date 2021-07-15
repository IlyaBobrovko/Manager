import Foundation

/**
 Server task responce model.
 */
class TaskResponse {
    
    /**
     Task.
     */
    var task: Task
    
    /**
     Task`s  project.
     */
    var project: Project?
    
    /**
     Task`s  employee.
     */
    var employee: Employee?
    
    /**
     Task responce initialization.
     
     - Parameters:
        - task: Task.
        - project: Task`s  project.
        - employee: Task`s  employee.
     */
    init(_ task: Task, project: Project?, employee: Employee?) {
        self.task = task
        self.project = project
        self.employee = employee
    }
}
