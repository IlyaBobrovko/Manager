import Foundation

/**
 Employee list methods.
 */
protocol EmployeeListDelegate {
    
    /**
     Select employee handler.
     
     - Parameters:
        - indexPath: Index.
     */
    func selectRow(at indexPath: IndexPath)
    
    /**
     Delete employee handler.
     
     - Parameters:
        - indexPath: Index.
     */
    func deleteRow(at indexPath: IndexPath)
}
