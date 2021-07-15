import Foundation

/**
 Task model.
 */
class Task {
    
    /**
     Task identifier.
     */
    var id: Int
    
    /**
     Task name.
     */
    var name: String
    
    /**
     Task work time in hours.
     */
    var workTime: Int
    
    /**
     Task start date.
     */
    var startDate: Date
    
    /**
     Task finish date.
     */
    var finishDate: Date
    
    /**
     Current task status.
     */
    var status: TaskStatus

    /**
     Identifier of project to witch the task belong.
     */
    var projectID: Int?
    
    /**
     Disignated employee identifier.
     */
    var employeeID: Int?
    
    /**
     Task model initialization.
     
     - Parameters:
        - name: Name.
        - workTime: Work time.
        - startDate: Start date.
        - finishDate: Finish date.
        - status: Status.
     */
    convenience init(name: String, workTime: Int, startDate: Date, finishDate: Date, status: TaskStatus) {
        self.init(id: -1, name: name, workTime: workTime, startDate: startDate, finishDate: finishDate, status: status)
    }
    
    /**
     Task model  initialization.
     
     - Parameters:
        - id: Identifier.
        - name: Name.
        - workTime: Work time.
        - startDate: Start date.
        - finishDate: Finish date.
        - status: Status.
    */
    init(id: Int, name: String, workTime: Int, startDate: Date, finishDate: Date, status: TaskStatus) {
        self.id = id
        self.name = name
        self.workTime = workTime
        self.startDate = startDate
        self.finishDate = finishDate
        self.status = status
    }
}
