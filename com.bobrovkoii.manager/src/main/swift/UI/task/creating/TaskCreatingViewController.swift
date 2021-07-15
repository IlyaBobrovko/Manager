import UIKit

/**
 Task creating view controller. Creates and saves new task.
 */
class TaskCreatingViewController: UIViewController, TaskViewDelegate {
    
    @IBOutlet private weak var taskView: TaskView!
    
    @IBOutlet private weak var activityView: ActivityView!
    
    private let server = AppDelegate.shared.stub
    
    /**
     Project for which the task is being creating.
     */
    private var currentProject: Project?
    
    /**
     Controller initialization.
     
     - Parameters:
        - project: Project for which the task is being creating.
     */
    convenience init(_ project: Project?) {
        self.init()
        self.currentProject = project
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
        taskView.bind(TaskViewModel(createNewTask(), currentProject, nil), projectLocked: currentProject != nil)
    }
    
    private func createNewTask() -> Task {
        let settings = AppDelegate.shared.settingsService.getSettings()
        var dateComponent = DateComponents()
        dateComponent.day = settings.daysCount
        
        let startDate = Date()
        let finishDate = Calendar.current.date(byAdding: dateComponent, to: Date()) ?? Date()

        return Task(name: "", workTime: 0, startDate: startDate, finishDate: finishDate, status: .notStarted)
    }
    
    @objc private func saveButtonTapped() {
        do {
            let taskModel = try taskView.unbind()
            activityView.showActivityView()
            server.addTask(taskModel.task) { [weak self] result in
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
                } completion: { element in
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
                } completion: { element in
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
