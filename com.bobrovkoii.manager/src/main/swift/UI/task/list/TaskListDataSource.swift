import UIKit

/**
 Implementation UITableViewDataSource and UITableViewDelegate for task table.
 */
class TaskListDataSource: NSObject, UITableViewDataSource, UITableViewDelegate {
            
    private var items = [TaskViewModel]()
    
    private var projectIsHidden = false
    
    /**
     Task list delegate.
     */
    var delegate: TaskListDelegate?
 
    /**
     Tasks list setter.
     
     - Parameters:
        - item: List of TaskViewModel.
        - projectLocked: Boolean value indicating whether project label is hidden.
     */
    func setTasks(_ item: [TaskViewModel], projectLocked: Bool) {
        self.items = item
        projectIsHidden = projectLocked
    }
    
    /**
     Tasks list getter.
     
     - Returns: List of TaskViewModel
     */
    func getTasks() -> [TaskViewModel] {
        return items
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let settings = AppDelegate.shared.settingsService.getSettings()
        return min(items.count, settings.elementsCount)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TaskViewCell.identifier) ?? UITableViewCell()
        if let taskCell = cell as? TaskViewCell {
            taskCell.bind(items[indexPath.row], projectIsHidden: projectIsHidden)
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
