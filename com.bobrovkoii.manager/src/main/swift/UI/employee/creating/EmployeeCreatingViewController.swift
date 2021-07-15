import UIKit

/**
 Employee creating view controller. Creates an saves new employee.
 */
class EmployeeCreatingViewController: UIViewController {
    
    @IBOutlet weak var employeeView: EmployeeView!
    
    @IBOutlet weak var activityView: ActivityView!
    
    private let server = AppDelegate.shared.stub
    
    /**
     Executes initial configuration of view.
     */
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        bind()
    }
    
    private func configureUI() {
        let saveButton = UIBarButtonItem(barButtonSystemItem: .save,
                                         target: self,
                                         action: #selector(saveButtonTapped))
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel,
                                           target: self,
                                           action: #selector(cancelButtonTapped))
        
        navigationItem.rightBarButtonItem = saveButton
        navigationItem.leftBarButtonItem = cancelButton
    }
    
    private func bind() {
        employeeView.bind()
    }
    
    @objc private func saveButtonTapped() {
        view.endEditing(true)
        do {
            let employee = try employeeView.unbind()
            activityView.showActivityView()
            server.addEmployee(employee) { [weak self] result in
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
}
