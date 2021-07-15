import UIKit

/**
  Employee list view controller. Shows list of employees.
 */
class EmployeeListController: UIViewController, EmployeeListDelegate {
    
    @IBOutlet private weak var employeesTableView: UITableView!
    
    @IBOutlet private weak var activityView: ActivityView!
    
    private let server = AppDelegate.shared.stub
        
    private let refreshControl = UIRefreshControl()
        
    private var tableDataSource = EmployeeListDataSource()
    
    /**
     Executes initial configuratuon of view.
     */
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        bind()
    }
    
    private func configureUI() {
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        navigationItem.rightBarButtonItem = addButton
        navigationItem.title = Localization.localize(key: "title.employees")
        
        let employeeCellNib = UINib(nibName: EmployeeViewCell.identifier, bundle: nil)
        employeesTableView.register(employeeCellNib, forCellReuseIdentifier: EmployeeViewCell.identifier)
        employeesTableView.dataSource = tableDataSource
        employeesTableView.delegate = tableDataSource
        
        tableDataSource.delegate = self
        
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        employeesTableView.addSubview(refreshControl)
    }

    private func bind() {
        server.getAllEmployees { [weak self] result in
            guard let self = self else {
                return
            }
            switch result {
            case .success(let employees):
                self.tableDataSource.setEmployees(employees)
               
            case .failure(let error):
                Alert.presentErrorAlert(on: self, message: Localization.localize(key: "error.server.loading"))
                Logger.logError(error)
            }
            
            self.employeesTableView.reloadData()
            self.activityView.hideActivityView()
            self.refreshControl.endRefreshing()
        }
    }

    @objc private func refresh() {
        bind()
    }

    @objc private func addButtonTapped(_ sender: UIBarButtonItem) {
        show(EmployeeCreatingViewController(), sender: self)
    }
    
    func deleteRow(at indexPath: IndexPath) {
        var employees = tableDataSource.getEmployees()
        activityView.showActivityView()
        server.deleteEmployee(id: employees[indexPath.row].id) { [weak self] result in
            guard let self = self else {
                return
            }
            switch result {
            case .success(_):
                employees.remove(at: indexPath.row)
                self.tableDataSource.setEmployees(employees)
                self.employeesTableView.reloadData()
                
            case .failure(let error):
                Alert.presentErrorAlert(on: self, message: Localization.localize(key: "error.server.loading"))
                Logger.logError(error)
            }
            self.activityView.hideActivityView()
        }
    }
    
    func selectRow(at indexPath: IndexPath) {
        let employees = tableDataSource.getEmployees()
        activityView.showActivityView()
        server.getEmployee(id: employees[indexPath.row].id) { [weak self] result in
            guard let self = self else {
                return
            }
            switch result {
            case .success(let employee):
                let editingController = EmployeeEditingViewController(employee)
                self.employeesTableView.deselectRow(at: indexPath, animated: true)
                self.show(editingController, sender: self)
                
            case .failure(let error):
                Alert.presentErrorAlert(on: self, message: Localization.localize(key: "error.server.loading"))
                Logger.logError(error)
            }
            self.activityView.hideActivityView()
        }
    }
}
