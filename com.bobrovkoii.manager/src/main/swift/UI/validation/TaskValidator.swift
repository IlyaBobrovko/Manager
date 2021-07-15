import Foundation

/**
 Task validator performs validation before task creating.
 */
class TaskValidator {
    
    /**
     Validate verifiable task and returns valid task or throws error.
     
     - Parameters:
        - task: Verifiable task.
     - Throws: ValidationError.
     - Returns: Valid task.
     */
    func validate(_ task: VerifiableTask) throws -> Task {
        let textValidator = TextValidator()
        let numberValidator = NumberValidator()
        let unwrapper = Unwrapper()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd"
        
        let name = try unwrapper.unwrap(task.name)
        let workTimeString = try unwrapper.unwrap(task.workTime)
        let startDateString = try unwrapper.unwrap(task.startDate)
        let finishDateString = try unwrapper.unwrap(task.finishDate)
        
        guard textValidator.notEmpty(name) else {
            throw ValidationError(message: Localization.localize(key: "error.validation.task.name"))
        }
        
        guard let workTime = Int(workTimeString), numberValidator.isPositive(workTime) else {
            throw ValidationError(message: Localization.localize(key: "error.validation.task.workTime"))
        }
        
        guard let startDate = dateFormatter.date(from: startDateString) else {
            throw ValidationError(message: Localization.localize(key: "error.validation.task.startDate"))
        }
        
        guard let finishDate = dateFormatter.date(from: finishDateString) else {
            throw ValidationError(message: Localization.localize(key: "error.validation.task.finishDate"))
        }
        
        guard startDate <= finishDate else {
            throw ValidationError(message: Localization.localize(key: "error.validation.task.dates"))
        }
        
        let validTask = Task(name: name,
                             workTime: workTime,
                             startDate: startDate,
                             finishDate: finishDate,
                             status: task.status)

        return validTask
    }
}
