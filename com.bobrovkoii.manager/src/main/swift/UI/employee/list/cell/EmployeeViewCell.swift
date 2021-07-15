import UIKit

/**
 Employye view cell.
 */
class EmployeeViewCell: UITableViewCell {
    
    /**
     Cell's nib name.
     */
    static let identifier = "EmployeeViewCell"

    @IBOutlet private weak var fullNameLabel: UILabel!
    
    @IBOutlet private weak var postLabel: UILabel!

    /**
     Bind employee using employee.
     
     - Parameters:
        - employee: Displayed employee.
     */
    func bind(_ item: Employee) {
        fullNameLabel.text = "\(item.surname) \(item.name) \(item.middleName)"
        postLabel.text = item.post
    }
}
