import UIKit

/**
 Project editing view controller. Edits and updates existing project.
 */
class ProjectEditingViewController: UIViewController {
    
    @IBOutlet weak var projectView: ProjectView!
    
    @IBOutlet weak var activityView: ActivityView!
        
    private let server = AppDelegate.shared.stub
    
    private var editingProject: Project
    
    /**
     Initialization with editing project.
     
     - Parameters:
        - project: Editing project.
     */
    init(_ project: Project) {
        self.editingProject = project
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("ProjectEditingViewController.init(coder:) has not been implemented")
    }
    
    /**
     Execute initial configuration of view.
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
        projectView.bind(editingProject)
    }
    
    @objc private func saveButtonTapped() {
        do {
            let project = try projectView.unbind()
            activityView.showActivityView()
            server.updateProject(project) { [weak self] result in
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
