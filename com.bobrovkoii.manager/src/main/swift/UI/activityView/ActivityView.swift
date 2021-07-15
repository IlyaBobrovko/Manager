import UIKit

/**
 Activity indicator view.
 */
class ActivityView: UIView {
    
    @IBOutlet private var view: UIView!
    
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!

    /**
     Executes initial configuratuon of view.
     */
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
     Show activity view.
     */
    func showActivityView() {
        activityIndicator.startAnimating()
        self.isHidden = false
    }
    
    /**
     Hide activity view.
     */
    func hideActivityView() {
        activityIndicator.stopAnimating()
        self.isHidden = true
    }
}
