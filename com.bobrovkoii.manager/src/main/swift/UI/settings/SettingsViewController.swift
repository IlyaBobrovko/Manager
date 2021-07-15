import UIKit

/**
 Settings view controller.
 */
class SettingsViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet private weak var urlServerTextField: UITextField!
    
    @IBOutlet private weak var maxNumberOfElementsTextField: UITextField!
    
    @IBOutlet private weak var daysToCompleteTextField: UITextField!
    
    private let settingsService = AppDelegate.shared.settingsService
    
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
        navigationItem.rightBarButtonItem = saveButton
        navigationItem.title = Localization.localize(key: "title.settings")
    }
    
    private func bind() {
        let settings = settingsService.getSettings()
        urlServerTextField.text = settings.url
        maxNumberOfElementsTextField.text = String(settings.elementsCount)
        daysToCompleteTextField.text = String(settings.daysCount)
    }
    
    private func unbind() throws -> Settings {
        let converter = Unwrapper()
        let textValidator = TextValidator()
        let numberValidator = NumberValidator()
        
        let url = try converter.unwrap(urlServerTextField.text)
        let elementCountString = try converter.unwrap(maxNumberOfElementsTextField.text)
        let daysCountString = try converter.unwrap(daysToCompleteTextField.text)
        
        guard let elementCount = Int(elementCountString),
              numberValidator.isPositive(elementCount) else {
            throw ValidationError(message: Localization.localize(key: "error.validation.settings.url"))
            
        }
        guard let dayCount = Int(daysCountString),
              numberValidator.isPositive(dayCount) else {
            throw ValidationError(message: Localization.localize(key: "error.validation.settings.daysCount"))
        }
        
        guard textValidator.notEmpty(url) else {
            throw ValidationError(message: Localization.localize(key: "error.validation.settings.elementsCount"))
        }
        
        return Settings(url: url, elementCount: elementCount, daysCount: dayCount)
    }
    
    @objc private func saveButtonTapped() {
        do {
            let settings = try unbind()
            try settingsService.setSettings(settings)
            navigationController?.popViewController(animated: true)
            
        } catch let error as ValidationError {
            Alert.presentErrorAlert(on: self, message: error.message)
        } catch {
            Alert.presentErrorAlert(on: self, message: Localization.localize(key: "error.unknown"))
            Logger.logError(error)
        }
    }
    
    /**
     UITextFieldDelegate method. Hide keyboard when tap on return button.
     */
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    /**
     Hide keyboard when tap on view.
     */
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}


