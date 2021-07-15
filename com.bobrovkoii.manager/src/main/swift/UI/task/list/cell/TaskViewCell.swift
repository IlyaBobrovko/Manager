import UIKit

/**
 Table view cell for displaying task. Used in task list.
 */
class TaskViewCell: UITableViewCell {

    /**
     Cell's nib name.
     */
    static let identifier = "TaskViewCell"

    @IBOutlet private weak var nameLabel: UILabel!
    
    @IBOutlet private weak var projectLabel: UILabel!
    
    @IBOutlet private weak var statusView: UIView!
        
    private let statusColor: [TaskStatus: UIColor] = [.notStarted : .red,
                                                      .active : .yellow,
                                                      .completed : .green,
                                                      .postponed : .gray]
 
    /**
     Execute initial configuration of cell.
     */
    override func awakeFromNib() {
        super.awakeFromNib()
        statusView.layer.cornerRadius = CGFloat(statusView.bounds.width / 2)
    }

    /**
     Configure cell using task.
     
     - Parameters:
        - item: TaskViewModel with task details.
        - projectIsHidden: Boolean value indicating whether project label is hidden.
     */
    func bind(_ item: TaskViewModel, projectIsHidden: Bool) {
        nameLabel.text = item.task.name
        projectLabel.text = item.project?.name
        projectLabel.isHidden = projectIsHidden
        
        statusView.backgroundColor = statusColor[item.task.status]
    }
}
