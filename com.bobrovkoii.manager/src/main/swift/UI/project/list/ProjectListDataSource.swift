import UIKit

/**
 Implementation UITableViewDataSource and UITableViewDelegate for table in ProjectListController.
 */
class ProjectListDataSource: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    private let settings = AppDelegate.shared.settingsService.getSettings()

    private var projects = [Project]()
        
    /**
     Projects list delegate.
     */
    var delegate: ProjectListDelegate?

    /**
     Projects list setter.
     
     - Parameters:
        - projects: Projects.
     */
    func setProjects(_ projects: [Project]) {
        self.projects = projects
    }
    
    /**
     Projects list getter.
     
     - Returns: Project list.
     */
    func getProjects() -> [Project] {
        return projects
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return min(projects.count, settings.elementsCount)
    }
     
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProjectViewCell.identifier) ?? UITableViewCell()
        if let projectCell = cell as? ProjectViewCell {
            projectCell.bind(projects[indexPath.row]) { [weak self] in
                guard let self = self else {
                    return
                }
                self.delegate?.showTasksForProject(indexPath)
            }
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
