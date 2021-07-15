import Foundation

/**
 Employee model.
 */
class Employee {
    
    /**
     Employee identifier.
     */
    var id: Int
    
    /**
     Employee name.
     */
    var name: String
    
    /**
     Employee surname.
     */
    var surname: String
    /**
     Employee middle name.
     */
    var middleName: String
    
    /**
     Employee post.
     */
    var post: String
    
    /**
     Employee initialization.
     
     - Parameters:
        - name: Name.
        - surname: Surname.
        - middleName: Middle name.
        - post: Post.
     */
    convenience init(name: String, surname: String, middleName: String, post: String) {
        self.init(id: -1, name: name, surname: surname, middleName: middleName, post: post)
    }
    
    /**
     Employee initialization.
     
     - Parameters:
        - id: Identifier.
        - name: Name.
        - surname: Surname.
        - middleName: Middle name.
        - post: Post.
     */
    init(id: Int, name: String, surname: String, middleName: String, post: String) {
        self.id = id
        self.name = name
        self.surname = surname
        self.middleName = middleName
        self.post = post
    }
}
