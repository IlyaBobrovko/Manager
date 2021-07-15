import  UIKit

/**
 Segmented control view for interaction with task status.
 */
class TaskStatusSwitcher: UISegmentedControl {
    
    /**
     All task status cases.
     */
    private let statuses = TaskStatus.allCases
    
    /**
     Set task status.
     
     - Parameters:
        - status: Task status.
     */
    func setStatus(_ status: TaskStatus) {
        // Switch segmented control to corresponding status case.
        switch status {
        case .notStarted:
            selectedSegmentIndex = 0
        case .active:
            selectedSegmentIndex = 1
        case .completed:
            selectedSegmentIndex = 2
        case .postponed:
            selectedSegmentIndex = 3
        }
    }
    
    /**
     Get selected status.
     
     - Returns: Selected task status.
     */
    func getStatus() -> TaskStatus {
        return statuses[selectedSegmentIndex]
    }
}
