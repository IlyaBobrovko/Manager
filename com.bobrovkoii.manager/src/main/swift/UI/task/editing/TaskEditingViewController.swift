import UIKit

/**
 Task editing view controller. Edits and updates task.
 */
class TaskEditingViewController: UIViewController, TaskViewDelegate {
    
    @IBOutlet private weak var taskView: TaskView!
    
    @IBOutlet private weak var activityView: ActivityView!
    
    private let server = AppDelegate.shared.stub
    
    /**
     Task view model with editing task.
     */
    private var taskModel: TaskViewModel
    
    /**
     Boolean value indicating whether project editing is enabled.
     */
    private var projectLocked = false
    
    /**
     Controller initialization.
     
     - Parameters:
        - taskModel: TaskViewModel with task for editing.
        - projectLocked: Boolean value indicating whether project editing is enabled.
     */
    init(_ taskModel: TaskViewModel, projectLocked: Bool) {
        self.taskModel = taskModel
        self.projectLocked = projectLocked
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("TaskEditingViewController.init(coder:) has not been implemented")
    }
    
    /**
     Executes initial configuration of view.
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        bind()
    }
    
    private func configureUI() {
        let saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveButtonTapped))
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelButtonTapped))
        
        navigationItem.rightBarButtonItem = saveButton
        navigationItem.leftBarButtonItem = cancelButton
        
        taskView.delegate = self
    }
    
    private func bind() {
        taskView.bind(taskModel, projectLocked: projectLocked)
    }
    
    @objc private func saveButtonTapped() {
        do {
            let taskModel = try taskView.unbind()
            activityView.showActivityView()
            server.updateTask(taskModel.task) { [weak self] result in
                guard let self = self else {
                    return
                }
                switch result {
                case .success(_):
                    self.navigationController?.popViewController(animated: true)
                    
                case .failure(let error):
                    self.activityView.hideActivityView()
                    Alert.presentErrorAlert(on: self, message: Localization.localize(key: "error.server.loading"))
                    Logger.logError(error)
                }
            }
        } catch let error as ValidationError {
            Alert.presentErrorAlert(on: self, message: error.message)
        } catch {
            Alert.presentErrorAlert(on: self, message: Localization.localize(key: "error.unknown"))
            Logger.logError(error)
        }
    }
    
    @objc private func cancelButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    func projectButtonTapped() {
        activityView.showActivityView()
        server.getAllProjects() { [weak self] result in
            guard let self = self else {
                return
            }
            switch result {
            case .success(let projects):
                let selectionController = SelectionListViewController(projects) { (cell, element) in
                    cell.textLabel?.text = element.name
                } completion: { (element) in
                    self.taskView.setProject(element)
                }
                
                self.show(selectionController, sender: self)
                
            case .failure(let error):
                Alert.presentErrorAlert(on: self, message: Localization.localize(key: "error.server.loading"))
                Logger.logError(error)
            }
            self.activityView.hideActivityView()
        }
    }
    
    func employeeButtonTapped() {
        activityView.showActivityView()
        server.getAllEmployees() { [weak self] result in
            guard let self = self else {
                return
            }
            switch result {
            case .success(let employees):
                let selectionController = SelectionListViewController(employees) { (cell, element) in
                    cell.textLabel?.text = ("\(element.name) \(element.middleName) \(element.surname)")
                } completion: { (element) in
                    self.taskView.setEmployee(element)
                }
                
                self.show(selectionController, sender: self)
                
            case .failure(let error):
                Alert.presentErrorAlert(on: self, message: Localization.localize(key: "error.server.loading"))
                Logger.logError(error)
            }
            self.activityView.hideActivityView()
        }
    }
}
