import Foundation

/**
 Task view methods.
 */
protocol TaskViewDelegate {
    
    /**
     Shows view with list of projects.
     */
    func projectButtonTapped()
    
    /**
     Shows view with list of employees.
     */
    func employeeButtonTapped()
}
