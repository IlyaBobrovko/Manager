import UIKit

/**
 Project list view controller.
 */
class ProjectListController: UIViewController, ProjectListDelegate {
    
    @IBOutlet private weak var projectsTableView: UITableView!
 
    @IBOutlet private weak var activityView: ActivityView!
    
    private let server = AppDelegate.shared.stub
            
    private var refreshControl = UIRefreshControl()
            
    private var tableDataSource = ProjectListDataSource()
    
    /**
     Execute initial configuration of view.
     */
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        bind()
    }
    
    private func configureUI() {
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        navigationItem.rightBarButtonItem = addButton
        navigationItem.title = Localization.localize(key: "title.projects")

        let cellNib = UINib(nibName: ProjectViewCell.identifier, bundle: nil)
        projectsTableView.register(cellNib, forCellReuseIdentifier: ProjectViewCell.identifier)
        projectsTableView.dataSource = tableDataSource
        projectsTableView.delegate = tableDataSource
        
        tableDataSource.delegate = self
        
        refreshControl.addTarget(self, action: #selector(refreshView), for: .valueChanged)
        projectsTableView.addSubview(refreshControl)
    }
    
    @objc private func addButtonTapped() {
        show(ProjectCreatingViewController(), sender: self)
    }

    @objc private func refreshView() {
        bind()
    }
    
    private func bind() {
        server.getAllProjects { [weak self] result in
            guard let self = self else {
                return
            }
            switch result {
            case .success(let projects):
                self.tableDataSource.setProjects(projects)
                
            case .failure(let error):
                Alert.presentErrorAlert(on: self, message: Localization.localize(key: "error.server.loading"))
                Logger.logError(error)
            }
            self.projectsTableView.reloadData()
            self.activityView.hideActivityView()
            self.refreshControl.endRefreshing()
        }
    }
    
    func selectRow(at indexPath: IndexPath) {
        let projects = tableDataSource.getProjects()
        activityView.showActivityView()
        server.getProject(id: projects[indexPath.row].id) { [weak self] result in
            guard let self = self else {
                return
            }
            switch result {
            case.success(let project):
                let editingController = ProjectEditingViewController(project)
                self.show(editingController, sender: self)
                
            case.failure(let error):
                Alert.presentErrorAlert(on: self, message: Localization.localize(key: "error.server.loading"))
                Logger.logError(error)
            }
            self.projectsTableView.deselectRow(at: indexPath, animated: true)
            self.activityView.hideActivityView()
        }
    }
    
    func deleteRow(at indexPath: IndexPath) {
        var projects = tableDataSource.getProjects()
        activityView.showActivityView()
        server.deleteProject(id: projects[indexPath.row].id) { [weak self] result in
            guard let self = self else {
                return
            }
            switch result {
            case .success(_):
                projects.remove(at: indexPath.row)
                self.tableDataSource.setProjects(projects)
                self.projectsTableView.reloadData()
                
            case .failure(let error):
                Alert.presentErrorAlert(on: self, message: Localization.localize(key: "error.server.loading"))
                Logger.logError(error)
            }
            self.activityView.hideActivityView()
        }
    }

    func showTasksForProject(_ indexPath: IndexPath) {
        let projects = tableDataSource.getProjects()
        activityView.showActivityView()
        server.getProject(id: projects[indexPath.row].id) { [weak self] result in
            guard let self = self else {
                return
            }
            switch result {
            case .success(let project):
                let taskListController = TaskListController(project)
                self.show(taskListController, sender: self)

            case .failure(let error):
                Alert.presentErrorAlert(on: self, message: Localization.localize(key: "error.server.loading"))
                Logger.logError(error)
            }
            self.activityView.hideActivityView()
        }
    }
}
