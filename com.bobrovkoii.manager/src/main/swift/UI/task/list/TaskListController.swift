import UIKit

/**
 Task List ViewController.
 */
class TaskListController: UIViewController, TaskListDelegate {
    
    @IBOutlet private weak var tasksTableView: UITableView!
    
    @IBOutlet private weak var activityView: ActivityView!
 
    private let server = AppDelegate.shared.stub
        
    private var refreshControl = UIRefreshControl()
        
    private var tableDataSource = TaskListDataSource()
    
    /**
     Project for which tasks are displayed.
     */
    private var currentProject: Project?
    
    /**
     Initializaion with selected project.
     
     - Parameters:
        - project: Project.
     */
    convenience init(_ project: Project) {
        self.init()
        currentProject = project
    }
    
    /**
     Executes initial configuration of view.
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        bind()
    }

    @objc private func addButtonTapped() {
        show(TaskCreatingViewController(currentProject), sender: self)
    }
    
    @objc private func refresh() {
        bind()
    }
    
    private func configureUI() {
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        tasksTableView.addSubview(refreshControl)
        
        let taskCellNib = UINib(nibName: TaskViewCell.identifier, bundle: nil)
        tasksTableView.register(taskCellNib, forCellReuseIdentifier: TaskViewCell.identifier)
        tasksTableView.dataSource = tableDataSource
        tasksTableView.delegate = tableDataSource
        tableDataSource.delegate = self
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        navigationItem.rightBarButtonItem = addButton
        navigationItem.title = Localization.localize(key: "title.tasks")
    }
    
    private func bind() {
        if let project = currentProject {
            server.getTasksForProject(id: project.id) { [weak self] result in
                guard let self = self else {
                    return
                }
                switch result {
                case .success(let tasksResponses):
                    let items = tasksResponses.map { TaskViewModel($0.task, $0.project, $0.employee) }
                    self.tableDataSource.setTasks(items, projectLocked: true)
                    
                case .failure(let error):
                    Alert.presentErrorAlert(on: self, message: Localization.localize(key: "error.server.loading"))
                    Logger.logError(error)
                }
                self.tasksTableView.reloadData()
                self.activityView.hideActivityView()
                self.refreshControl.endRefreshing()
            }
        }
        else {
            server.getAllTasks { [weak self] result in
                guard let self = self else {
                    return
                }
                switch result {
                case .success(let tasksResponses):
                    let items = tasksResponses.map { TaskViewModel($0.task, $0.project, $0.employee) }
                    self.tableDataSource.setTasks(items, projectLocked: false)

                case .failure(let error):
                    Alert.presentErrorAlert(on: self, message: Localization.localize(key: "error.server.loading"))
                    Logger.logError(error)
                }
                self.tasksTableView.reloadData()
                self.activityView.hideActivityView()
                self.refreshControl.endRefreshing()
            }
        }
    }
    
    func selectRow(at indexPath: IndexPath) {
        let tasks = tableDataSource.getTasks()
        activityView.showActivityView()
        server.getTask(id: tasks[indexPath.row].task.id) { [weak self] result in
            guard let self = self else {
                return
            }
            switch result {
            case .success(let response):
                let taskModel = TaskViewModel(response.task, response.project, response.employee)
                self.show(TaskEditingViewController(taskModel, projectLocked: self.currentProject != nil), sender: self)
      
            case .failure(let error):
                Alert.presentErrorAlert(on: self, message: Localization.localize(key: "error.server.loading"))
                Logger.logError(error)
            }
            self.tasksTableView.deselectRow(at: indexPath, animated: true)
            self.activityView.hideActivityView()
        }
    }
    
    func deleteRow(at indexPath: IndexPath) {
        var tasks = tableDataSource.getTasks()
        activityView.showActivityView()
        server.deleteTask(id: tasks[indexPath.row].task.id) { [weak self] result in
            guard let self = self else {
                return
            }
            switch result {
            case .success(_):
                tasks.remove(at: indexPath.row)
                self.tableDataSource.setTasks(tasks, projectLocked: self.currentProject != nil)
                self.tasksTableView.reloadData()
                
            case .failure(let error):
                Alert.presentErrorAlert(on: self, message: Localization.localize(key: "error.server.loading"))
                Logger.logError(error)
            }
            self.activityView.hideActivityView()
        }
    }
}

