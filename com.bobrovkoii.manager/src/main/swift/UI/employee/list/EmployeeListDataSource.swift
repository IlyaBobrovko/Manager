import UIKit

/**
 Implementation UITableViewDataSource and UITableViewDelegate for employee table.
 */
class EmployeeListDataSource: NSObject, UITableViewDataSource, UITableViewDelegate {

    private let settings = AppDelegate.shared.settingsService.getSettings()
        
    private var employees = [Employee]()

    /**
     Employee list delegate.
     */
    var delegate: EmployeeListDelegate?
    
    /**
     Employee list setter.
     
     - Parameters:
        - employees: Employee list.
     */
    func setEmployees(_ employees: [Employee]) {
        self.employees = employees
    }
    
    /**
     Employee list getter.
     
     - Returns: Employee list.
     */
    func getEmployees() -> [Employee] {
        return employees
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return min(employees.count, settings.elementsCount)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: EmployeeViewCell.identifier) ?? UITableViewCell()
        if let employeeCell = cell as? EmployeeViewCell {
            employeeCell.bind(employees[indexPath.row])
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView,
                   commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            delegate?.deleteRow(at: indexPath)
        }
    }
        
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.selectRow(at: indexPath)
    }
}
