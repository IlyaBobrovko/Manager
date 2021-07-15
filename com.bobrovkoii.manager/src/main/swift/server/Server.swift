import Foundation

/**
 Server requests.
 */
protocol Server {
    
    /**
     Appending new project.
     
     - Parameters:
        - project: New project.
        - completion: Block that is executed after the request completes.
                      Contains a value that represents either a success or a failure of request.
                      Success: returns Void.
                      Faliure: returns error of server request.
     */
    func addProject(_ project: Project, _ completion: @escaping ((Result<Void, Error>) -> Void))
    
    /**
     Appending new task.
     
     - Parameters:
        - task: New task.
        - completion: Block that is executed after the request completes.
                      Contains a value that represents either a success or a failure of request.
                      Success: returns Void.
                      Faliure: returns error of server request.
     */
    func addTask(_ task: Task, _ completion: @escaping ((Result<Void, Error>) -> Void))
    
    /**
     Appending new employee.
     
     - Parameters:
        - employee: New employee.
        - completion: Block that is executed after the request completes.
                      Contains a value that represents either a success or a failure of request.
                      Success: returns Void.
                      Faliure: returns error of server request.
     */
    func addEmployee(_ employee: Employee, _ completion: @escaping ((Result<Void, Error>) -> Void))
    
    /**
    Removing project by identifier.
     
     - Parameters:
        - id: Identifier.
        - completion: Block that is executed after the request completes.
                      Contains a value that represents either a success or a failure of request.
                      Success: returns Void.
                      Faliure: returns error of server request.
    */
    func deleteProject(id: Int, _ completion: @escaping ((Result<Void, Error>) -> Void))
    
    /**
     Removing task by identifier.
     
     - Parameters:
        - id: Identifier.
        - completion: Block that is executed after the request completes.
                      Contains a value that represents either a success or a failure of request.
                      Success: returns Void.
                      Faliure: returns error of server request.
     */
    func deleteTask(id: Int, _ completion: @escaping ((Result<Void, Error>) -> Void))
    
    /**
     Removing employee by identifier.
     
     - Parameters:
        - id: Identifier.
        - completion: Block that is executed after the request completes.
                      Contains a value that represents either a success or a failure of request.
                      Success: returns Void.
                      Faliure: returns error of server request.
    */
    func deleteEmployee(id: Int, _ completion: @escaping ((Result<Void, Error>) -> Void))
    
    /**
     Fetching project by identifier.
     
     - Parameters:
        -  id: Identifier.
        - completion: Block that is executed after the request completes.
                      Contains a value that represents either a success or a failure of request.
                      Success: returns project.
                      Faliure: returns error of server request.
     */
    func getProject(id: Int, _ completion: @escaping ((Result<Project, Error>) -> Void))
    
    /**
     Fetching task by identifier.
     
     - Parameters:
        -  id: Identifier.
        - completion: Block that is executed after the request completes.
                      Contains a value that represents either a success or a failure of request.
                      Success: returns task response model.
                      Faliure: returns error of server request.
     */
    func getTask(id: Int, _ completion: @escaping ((Result<TaskResponse, Error>) -> Void))
    
    /**
     Fetching employee by identifier.
     
     - Parameters:
        -  id: Identifier.
        - completion: Block that is executed after the request completes.
                      Contains a value that represents either a success or a failure of request.
                      Success: returns employee.
                      Faliure: returns error of server request.
     */
    func getEmployee(id: Int, _ completion: @escaping ((Result<Employee, Error>) -> Void))
    
    /**
     Fetching all tasks by project identifier.
     
     - Parameters:
        -  id: Identifier.
        - completion: Block that is executed after the request completes.
                      Contains a value that represents either a success or a failure of request.
                      Success: returns array of task responses.
                      Faliure: returns error of server request.
     */
    func getTasksForProject(id: Int, _ completion: @escaping ((Result<[TaskResponse], Error>) -> Void))
    
    /**
     Fetching all projects.
     
     - Parameters:
        - completion: Block that is executed after the request completes.
                      Contains a value that represents either a success or a failure of request.
                      Success: returns array of projects.
                      Faliure: returns error of server request.
    */
    func getAllProjects(_ completion: @escaping ((Result<[Project], Error>) -> Void))
    
    /**
     Fetching all tasks.
     
     - Parameters:
        - completion: Block that is executed after the request completes.
                      Contains a value that represents either a success or a failure of request.
                      Success: returns array of task responses.
                      Faliure: returns error of server request.
    */
    func getAllTasks(_ completion: @escaping ((Result<[TaskResponse], Error>) -> Void))
    
    /**
     Fetching all employees.
     
     - Parameters:
        - completion: Block that is executed after the request completes.
                      Contains a value that represents either a success or a failure of request.
                      Success: returns array of  employees.
                      Faliure: returns error of server request.
    */
    func getAllEmployees(_ completion: @escaping ((Result<[Employee], Error>) -> Void))
    
    /**
     Update project.
     
     - Parameters:
        - project: Updating project.
        - completion: Block that is executed after the request completes.
                      Contains a value that represents either a success or a failure of request.
                      Success: returns Void.
                      Faliure: returns error of server request.
     */
    func updateProject(_ project: Project, _ completion: @escaping ((Result<Void, Error>) -> Void))
    
    /**
     Update task.
     
     - Parameters:
        - task: Updating task.
        - completion: Block that is executed after the request completes.
                      Contains a value that represents either a success or a failure of request.
                      Success: returns Void.
                      Faliure: returns error of server request.
     */
    func updateTask(_ task: Task, _ completion: @escaping ((Result<Void, Error>) -> Void))
    
    /**
     Update employee.
     
     - Parameters:
        - employee: Updating employee.
        - completion: Block that is executed after the request completes.
                      Contains a value that represents either a success or a failure of request.
                      Success: returns Void.
                      Faliure: returns error of server request.
     */
    func updateEmployee(_ employee: Employee, _ completion: @escaping ((Result<Void, Error>) -> Void))
}
