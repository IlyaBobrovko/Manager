import Foundation

/**
 Project model.
 */
class Project {
    
    /**
     Project identifier.
     */
    var id: Int
    
    /**
     Project name.
     */
    var name: String
    
    /**
     Project detail.
     */
    var detail: String
    
    /**
     Project initialization.
     
     - Parameters:
        - name: Project name.
        - detail: Project detail.
     */
    convenience init(name: String, detail: String) {
        self.init(id: -1, name: name, detail: detail)
    }
    
    /**
     Project initialization.
     
     - Parameters:
        - id: Project identifier.
        - name: Project name.
        - detail: Project detail.
     */
    init(id: Int, name: String, detail: String) {
        self.id = id
        self.name = name
        self.detail = detail
    }
}
