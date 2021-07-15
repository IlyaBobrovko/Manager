import UIKit

/**
 View for editing details of task model. Used in editing and creating task controllers.
 */
class TaskView: UIView, UITextFieldDelegate {
        
    @IBOutlet private var view: UIView!
    
    @IBOutlet private weak var taskNameTextField: UITextField!
    
    @IBOutlet private weak var projectButton: UIButton!
    
    @IBOutlet private weak var employeeButton: UIButton!

    @IBOutlet private weak var workTimeTextField: UITextField!
    
    @IBOutlet private weak var statusSwitcher: TaskStatusSwitcher!
    
    @IBOutlet private weak var startDateTextField: UITextField!
    
    @IBOutlet private weak var startDatePicker: UIDatePicker!
    
    @IBOutlet private weak var finishDateTextField: UITextField!
    
    @IBOutlet private weak var finishDatePicker: UIDatePicker!
        
    private let dateFormatter = DateFormatter()
    
    private var taskModel: TaskViewModel?

    /**
     Task view delegate.
     */
    var delegate: TaskViewDelegate?

    /**
     Executes initial configuration of view.
     */
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }
    
    @IBAction private func projectButtonTapped(_ sender: UIButton) {
        delegate?.projectButtonTapped()
    }
    
    @IBAction private func employeeButtonTapped(_ sender: UIButton) {
        delegate?.employeeButtonTapped()
    }
    
    @IBAction private func startDateTextFieldChanged() {
        if let startDate = startDateTextField.text, let date = dateFormatter.date(from: startDate) {
            startDatePicker.date = date
        }
    }
    
    @IBAction private func finishDateTextFieldChanged() {
        if let finishDate = finishDateTextField.text, let date = dateFormatter.date(from: finishDate) {
            finishDatePicker.date = date
        }
    }
    
    @IBAction private func startDatePickerChanged() {
        startDateTextField.text = dateFormatter.string(from: startDatePicker.date)
    }
    
    @IBAction private func finishDatePickerChanged() {
        finishDateTextField.text = dateFormatter.string(from: finishDatePicker.date)
    }
    
    /**
     UITextFieldDelegate method. Hide keyboard when tap on return button.
     */
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    private func configureUI() {
        Bundle.main.loadNibNamed(String(describing: type(of: self)), owner: self, options: nil)
        view.frame = bounds
        addSubview(view)
        
        dateFormatter.dateFormat = "YYYY-MM-dd"
    }

    /**
     Bind task view using TaskViewModel.
     
     - Parameters:
        - item: Task view model.
        - projectLocked: Boolean value indicating whether project editing is enabled.
     */
    func bind(_ item: TaskViewModel, projectLocked: Bool) {
        taskModel = item

        taskNameTextField.text = item.task.name

        workTimeTextField.text = String(item.task.workTime)

        statusSwitcher.setStatus(item.task.status)
        
        startDatePicker.date = item.task.startDate
        
        finishDatePicker.date = item.task.finishDate
        
        startDateTextField.text = dateFormatter.string(from: item.task.startDate)

        finishDateTextField.text = dateFormatter.string(from: item.task.finishDate)
        
        if let project = item.project {
            projectButton.setTitle(project.name, for: .normal)
        }

        if let employee = item.employee {
            employeeButton.setTitle("\(employee.surname) \(employee.name) \(employee.middleName)", for: .normal)
        }

        projectButton.isEnabled = !projectLocked
    }
    
    /**
     Set project for current task.
     
     - Parameters:
        - project: Project.
     */
    func setProject(_ project: Project) {
        projectButton.setTitle(project.name, for: .normal)
        taskModel?.project = project
    }
    
    /**
     Set employee for current task.
     
     - Parameters:
        - employee: Employee.
     */
    func setEmployee(_ employee: Employee) {
        employeeButton.setTitle("\(employee.surname) \(employee.name) \(employee.middleName)", for: .normal)
        taskModel?.employee = employee
    }

    /**
     Unbind task view. Returns new or updated task.
     Throws validation error if task cannot be created or edited.
     
     - Throws: Validation error if one of the fields is invalid.
     - Returns: Task View Model.
     */
    func unbind() throws -> TaskViewModel {
        
        let task = VerifiableTask(name: taskNameTextField.text,
                                  workTime: workTimeTextField.text,
                                  status: statusSwitcher.getStatus(),
                                  startDate: startDateTextField.text,
                                  finishDate: finishDateTextField.text)
        
        let validTask = try TaskValidator().validate(task)
        
        if let id = taskModel?.task.id {
            validTask.id = id
        }
        
        validTask.projectID = taskModel?.project?.id
        validTask.employeeID = taskModel?.employee?.id
        
        return TaskViewModel(validTask, taskModel?.project, taskModel?.employee)
    }
}
