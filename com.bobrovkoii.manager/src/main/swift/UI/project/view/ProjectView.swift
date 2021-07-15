import UIKit

/**
 View for editing details of project model. Used in editing and creating project controllers.
 */
class ProjectView: UIView, UITextFieldDelegate {
        
    @IBOutlet private var view: UIView!
    
    @IBOutlet private weak var nameTextField: UITextField!
    
    @IBOutlet private weak var detailTextField: UITextField!
            
    private var project: Project?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }
    
    private func configureUI() {
        Bundle.main.loadNibNamed(String(describing: type(of: self)), owner: self, options: nil)
        view.frame = bounds
        addSubview(view)
    }

    /**
     UITextFieldDelegate method. Hide keyboard when tap on return button.
     */
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    /**
     Bind view with project.
     
     - Parameters:
        - item: Project.
     */
    func bind(_ item: Project? = nil) {
        project = item
        nameTextField.text = item?.name
        detailTextField.text = item?.detail
    }
    
    /**
     Unbind project view. Returns new or updated project.
     Throws validation error if project cannot be created or edited.
     
     - Throws: ValidationError.
     - Returns: Project.
     */
    func unbind() throws -> Project {
        
        let converter = Unwrapper()
        let textValidator = TextValidator()
        
        let name = try converter.unwrap(nameTextField.text)
        let detail = try converter.unwrap(detailTextField.text)

        guard textValidator.notEmpty(name) else {
            throw ValidationError(message: Localization.localize(key: "error.validation.project.name"))
        }
        
        guard textValidator.notEmpty(detail) else {
            throw ValidationError(message: Localization.localize(key: "error.validation.project.detail"))
        }
        
        let newProject = Project(name: name, detail: detail)
        
        if let id = project?.id {
            newProject.id = id
        }
        return newProject
    }
}
