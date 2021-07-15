import Foundation

/**
 Model contains details of task.
 */
class TaskViewModel {
    
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
    init(_ task: Task, _ project: Project?, _ employee: Employee?) {
        self.task = task
        self.project = project
        self.employee = employee
    }
}
