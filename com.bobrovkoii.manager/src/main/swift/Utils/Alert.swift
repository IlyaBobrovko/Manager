import UIKit

/**
 Alert presenter.
 */
class Alert {
    
    /**
     Present alert on ViewController.
     
     - parameters:
        - vc: ViewController for presenting.
        - message: Alert message.
     */
    static func presentErrorAlert(on viewController: UIViewController, message: String) {
        let title = Localization.localize(key: "error")
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: Localization.localize(key: "button.ok"), style: .cancel, handler: nil))
        viewController.present(alert, animated: true)
    }
}
