import UIKit

/**
 Main menu view controller. Used for initial navigation in application.
 */
class MenuViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = Localization.localize(key: "title.menu")
    }
    
    @IBAction private func projectsButtonTapped() {
        show(ProjectListController(), sender: self)
    }
    
    @IBAction private func tasksButtonTapped() {
        show(TaskListController(), sender: self)
    }
    
    @IBAction private func employeesButtonTapped() {
        show(EmployeeListController(), sender: self)
    }
    
    @IBAction private func settingsButtonTapped() {
        show(SettingsViewController(), sender: self)
    }
}

