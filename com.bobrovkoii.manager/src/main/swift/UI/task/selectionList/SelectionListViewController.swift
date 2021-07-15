import UIKit

/**
 Selection list controller uses table view for present and select from given elements.
 */
class SelectionListViewController<Type>: UITableViewController {
    
    private var elements: [Type]
    
    private var configure: (UITableViewCell, Type) -> Void
    
    private var completion: (Type) -> Void
    
    /**
     List ViewController initialization.
     
     - Parameters:
        - elements: List of items to select.
        - configure: Configuration of list cell.
        - completion: Completion handler.
     */
    init(_ elements: [Type], configure: @escaping (UITableViewCell, Type) -> Void, completion: @escaping (Type) -> Void) {
        self.elements = elements
        self.configure = configure
        self.completion = completion
        super.init(nibName: nil, bundle: nil)
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }
    
    required init?(coder: NSCoder) {
        fatalError("SelectionListViewController.init(coder:) has not been implemented")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return elements.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") ?? UITableViewCell()
        configure(cell, elements[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        completion(elements[indexPath.row])
        navigationController?.popViewController(animated: true)
    }
}
