import UIKit

/**
 Project view cell. Used in project list.
 */
class ProjectViewCell: UITableViewCell {
    
    /**
     Project cell identifier.
     */
    static let identifier = "ProjectViewCell"
    
    @IBOutlet private weak var nameLabel: UILabel!
    
    @IBOutlet private weak var detailLabel: UILabel!
    
    /**
     Hadler executed with taskButton action.
     */
    private var taskButtonHandler: (() -> Void)?
        
    /**
     Task list button action. Shows list of tasks for selected porject.
     */
    @IBAction private func showTaskList() {
        taskButtonHandler?()
    }

    /**
     Configure cell with project.
     
     - Parameters:
        - item: Displayed project.
        - taskButtonHandler: Hadler executed with taskButton action.
     */
    func bind(_ item: Project, taskButtonHandler: @escaping (() -> Void)) {
        nameLabel.text = item.name
        detailLabel.text = item.detail
        self.taskButtonHandler = taskButtonHandler
    }
}
