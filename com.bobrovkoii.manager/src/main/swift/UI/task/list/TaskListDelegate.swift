import Foundation

/**
 Task list methods.
 */
protocol TaskListDelegate {
    
    /**
     Select task handler.
     
     - Parameters:
        - indexPath: Index.
     */
    func selectRow(at indexPath: IndexPath)
    
    /**
     Delete task handler.
     
     - Parameters:
        - indexPath: Index.
     */
    func deleteRow(at indexPath: IndexPath)
}

