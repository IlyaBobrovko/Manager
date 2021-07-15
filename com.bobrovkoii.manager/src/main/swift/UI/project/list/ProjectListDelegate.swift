import Foundation

/**
 Project table methods.
 */
protocol ProjectListDelegate {
    
    /**
     Select row handler.
     
     - Parameters:
        - indexPath: Index for cell in table.
     */
    func selectRow(at indexPath: IndexPath)
    
    /**
     Delete row handler.
     
     - Parameters:
        - indexPath: Index for cell in table.
     */
    func deleteRow(at indexPath: IndexPath)
    
    /**
     Show list of tasks for selected project.
     
     - Parameters:
        - indexPath: IndexPath of selected project.
     */
    func showTasksForProject(_ indexPath: IndexPath)
}
