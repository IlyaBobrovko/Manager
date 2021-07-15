import Foundation

/**
 Verifiable task model used for validation of task before creating. Used by TaskValidator.
 */
class VerifiableTask {
        
    /**
     Name.
     */
    var name: String?
    
    /**
     Work time.
     */
    var workTime: String?
    
    /**
     Task status.
     */
    var status: TaskStatus
    
    /**
     Start date string.
     */
    var startDate: String?
    
    /**
     Finish date string.
     */
    var finishDate: String?

    /**
     Model initialization:
     
     - Parameters:
        - name: Name.
        - workTime: Work time.
        - status: Status.
        - startDate: Start date.
        - finishDate: Finish date.
     */
    init(name: String?, workTime: String?, status: TaskStatus, startDate: String?, finishDate: String?) {
        self.name = name
        self.workTime = workTime
        self.status = status
        self.startDate = startDate
        self.finishDate = finishDate
    }
}
