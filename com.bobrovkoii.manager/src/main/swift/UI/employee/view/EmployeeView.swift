import UIKit

/**
 View for editing details of employee model. Used in editing and creating enployee controllers.
 */
class EmployeeView: UIView, UITextFieldDelegate {
    
    @IBOutlet var view: UIView!
    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var surnameTextField: UITextField!
    
    @IBOutlet weak var middleNameTextField: UITextField!
    
    @IBOutlet weak var postTextField: UITextField!
    
    private var employee: Employee?
    
    /**
     Executes initial configuration of view.
     */
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }
    
    private func configureUI() {
        Bundle.main.loadNibNamed(String(describing: type(of: self)), owner: self, options: nil)
        view.frame = bounds
        addSubview(view)
        
        nameTextField.delegate = self
        surnameTextField.delegate = self
        middleNameTextField.delegate = self
        postTextField.delegate = self
    }
    
    /**
     UITextFieldDelegate method. Hide keyboard when tap on return button.
     */
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    /**
     Bind employee view using employee model.
     
     - Parameters:
        - item: Employee.
     */
    func bind(_ item: Employee? = nil) {
        employee = item
        
        nameTextField.text = item?.name
        middleNameTextField.text = item?.middleName
        surnameTextField.text = item?.surname
        postTextField.text = item?.post
    }
    
    /**
     Unbind employee view. Returns new or updated employee.
     Throws validation error if employee cannot be created or edited.
     
     - Throws: Validation error.
     - Returns: Employee.
     */
    func unbind() throws -> Employee {
        let unwrapper = Unwrapper()
        let textValidator = TextValidator()
        
        let name = try unwrapper.unwrap(nameTextField.text)
        let surname = try unwrapper.unwrap(surnameTextField.text)
        let middleName = try unwrapper.unwrap(middleNameTextField.text)
        let post = try unwrapper.unwrap(postTextField.text)
        
        guard textValidator.notEmpty(name) else {
            throw ValidationError(message: Localization.localize(key: "error.validation.employee.name" ))
        }
        
        guard textValidator.notEmpty(surname) else {
            throw ValidationError(message: Localization.localize(key: "error.validation.employee.surname" ))
        }
        
        guard textValidator.notEmpty(middleName) else {
            throw ValidationError(message: Localization.localize(key: "error.validation.employee.middleName" ))
        }
        
        guard textValidator.notEmpty(post) else {
            throw ValidationError(message: Localization.localize(key: "error.validation.employee.post" ))
        }
        
        let newEmployee = Employee(name: name, surname: surname, middleName: middleName, post: post)
        
        if let id = employee?.id {
            newEmployee.id = id
        }
        return newEmployee
    }
}
