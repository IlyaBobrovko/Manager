import Foundation

/**
 Stub server.
 */
class Stub: Server {
    
    private var projects: [Project]
    
    private var tasks: [Task]
    
    private var employees: [Employee]
    
    private let generator = TestDataGenerator()
    
    private let stubDelay = 1.0
    
    /**
     Stub initialization with creating test data.
     */
    init() {
        projects = generator.testProjects()
        tasks = generator.testTasks()
        employees = generator.testEmployees()
    }
    
    func addProject(_ project: Project, _ completion: @escaping ((Result<Void, Error>) -> Void)) {
        DispatchQueue.global(qos: .background).asyncAfter(deadline: .now() + stubDelay) {
            project.id = self.generator.generateIdentifier()
            self.projects.append(project)
            
            DispatchQueue.main.async {
                completion(.success(()))
            }
        }
    }
    
    func addTask(_ task: Task, _ completion: @escaping ((Result<Void, Error>) -> Void)) {
        DispatchQueue.global(qos: .background).asyncAfter(deadline: .now() + stubDelay) {
            task.id = self.generator.generateIdentifier()
            self.tasks.append(task)
            
            DispatchQueue.main.async {
                completion(.success(()))
            }
        }
    }
    
    func addEmployee(_ employee: Employee, _ completion: @escaping ((Result<Void, Error>) -> Void)) {
        DispatchQueue.global(qos: .background).asyncAfter(deadline: .now() + stubDelay) {
            employee.id = self.generator.generateIdentifier()
            self.employees.append(employee)
            
            DispatchQueue.main.async {
                completion(.success(()))
            }
        }
    }
    
    func deleteProject(id: Int, _ completion: @escaping ((Result<Void, Error>) -> Void)) {
        DispatchQueue.global(qos: .background).asyncAfter(deadline: .now() + stubDelay) {
            
            let filteredProject = self.projects.filter { project in
                project.id == id
            }
            
            guard !filteredProject.isEmpty else {
                DispatchQueue.main.async {
                    completion(.failure(ServerError(message: "Unable to delete project with id: \(id)")))
                }
                return
            }
            
            self.projects.removeAll { $0.id == id }
            self.tasks.filter { $0.projectID == id }.forEach { $0.projectID = nil }
            
            DispatchQueue.main.async {
                completion(.success(()))
            }
        }
    }
    
    func deleteTask(id: Int, _ completion: @escaping ((Result<Void, Error>) -> Void)) {
        DispatchQueue.global(qos: .background).asyncAfter(deadline: .now() + stubDelay) {
            
            let filteredTasks = self.tasks.filter { task in
                task.id == id
            }
            
            guard !filteredTasks.isEmpty else {
                DispatchQueue.main.async {
                    completion(.failure(ServerError(message: "Unable to delete task with id: \(id)")))
                }
                return
            }
            
            self.tasks.removeAll { $0.id == id }
            
            DispatchQueue.main.async {
                completion(.success(()))
            }
        }
    }
    
    func deleteEmployee(id: Int, _ completion: @escaping ((Result<Void, Error>) -> Void)) {
        DispatchQueue.global(qos: .background).asyncAfter(deadline: .now() + stubDelay) {
            
            let filteredEmployee = self.employees.filter { employee in
                employee.id == id
            }
            
            guard !filteredEmployee.isEmpty else {
                DispatchQueue.main.async {
                    completion(.failure(ServerError(message: "Unable to delete employee with id: \(id)")))
                }
                return
            }
            
            self.employees.removeAll { $0.id == id }
            self.tasks.filter { $0.employeeID == id }.forEach { $0.employeeID = nil }
            
            DispatchQueue.main.async {
                completion(.success(()))
            }
        }
    }
    
    func getProject(id: Int, _ completion: @escaping ((Result<Project, Error>) -> Void)) {
        DispatchQueue.global(qos: .background).asyncAfter(deadline: .now() + stubDelay) {
            
            DispatchQueue.main.async {
                if let project = (self.projects.filter{ $0.id == id }.first) {
                    completion(.success(project))
                }
                else {
                    completion(.failure(ServerError(message: "Unable to fetch project with id: \(id)")))
                }
            }
        }
    }
    
    func getTask(id: Int, _ completion: @escaping ((Result<TaskResponse, Error>) -> Void)) {
        DispatchQueue.global(qos: .background).asyncAfter(deadline: .now() + stubDelay) {
            
            DispatchQueue.main.async {
                if let task = (self.tasks.filter{ $0.id == id }.first) {
                    let response = TaskResponse(task,
                                                project: self.projects.filter { $0.id == task.projectID }.first,
                                                employee: self.employees.filter { $0.id == task.employeeID}.first)
                    
                    completion(.success(response))
                }
                else {
                    completion(.failure(ServerError(message: "Unable to fetch task with id: \(id)")))
                }
            }
        }
    }
    
    func getEmployee(id: Int, _ completion: @escaping ((Result<Employee, Error>) -> Void)) {
        DispatchQueue.global(qos: .background).asyncAfter(deadline: .now() + stubDelay) {
            
            DispatchQueue.main.async {
                if let employee = (self.employees.filter{ $0.id == id }.first) {
                    completion(.success(employee))
                }
                else {
                    completion(.failure(ServerError(message: "Unable to fetch employee with id: \(id)")))
                }
            }
        }
    }
    
    func getTasksForProject(id: Int, _ completion: @escaping ((Result<[TaskResponse], Error>) -> Void)) {
        DispatchQueue.global(qos: .background).asyncAfter(deadline: .now() + stubDelay) {
            
            let filteredProject = self.projects.filter { project in
                project.id == id
            }
            
            guard !filteredProject.isEmpty else {
                DispatchQueue.main.async {
                    completion(.failure(ServerError(message: "Unable to fetch tasks for project with id: \(id)")))
                }
                return
            }
            
            let tasks = self.tasks.filter { $0.projectID == id }
            
            let result = tasks.map { task in
                TaskResponse(task,
                             project: self.projects.filter { $0.id == task.projectID }.first,
                             employee: self.employees.filter { $0.id == task.employeeID}.first)
            }
            
            DispatchQueue.main.async {
                completion(.success(result.sorted { $0.task.id < $1.task.id }))
            }
        }
    }
    
    func getAllProjects(_ completion: @escaping ((Result<[Project], Error>) -> Void)) {
        DispatchQueue.global(qos: .background).asyncAfter(deadline: .now() + stubDelay) {
            let projects = self.projects.sorted{ $0.id < $1.id }
            
            DispatchQueue.main.async {
                completion(.success(projects))
            }
        }
    }
    
    func getAllTasks(_ completion: @escaping ((Result<[TaskResponse], Error>) -> Void)) {
        DispatchQueue.global(qos: .background).asyncAfter(deadline: .now() + stubDelay) {
            
            let result = self.tasks.map { task in
                TaskResponse(task,
                             project: self.projects.filter { $0.id == task.projectID }.first,
                             employee: self.employees.filter { $0.id == task.employeeID}.first)
            }
            
            DispatchQueue.main.async {
                completion(.success( result.sorted { $0.task.id < $1.task.id } ))
            }
        }
    }
    
    func getAllEmployees(_ completion: @escaping ((Result<[Employee], Error>) -> Void)) {
        DispatchQueue.global(qos: .background).asyncAfter(deadline: .now() + stubDelay) {
            
            DispatchQueue.main.async {
                completion(.success(self.employees.sorted{ $0.id < $1.id }))
            }
        }
    }
    
    func updateProject(_ project: Project, _ completion: @escaping ((Result<Void, Error>) -> Void)) {
        DispatchQueue.global(qos: .background).asyncAfter(deadline: .now() + stubDelay) {
            
            DispatchQueue.main.async {
                if let index = self.projects.firstIndex(where: { $0.id == project.id }) {
                    self.projects[index] = project
                    completion(.success(()))
                }
                else {
                    completion(.failure(ServerError(message: "Unable to update project with id: \(project.id)")))
                }
            }
        }
    }
    
    func updateTask(_ task: Task, _ completion: @escaping ((Result<Void, Error>) -> Void)) {
        DispatchQueue.global(qos: .background).asyncAfter(deadline: .now() + stubDelay) {
            
            DispatchQueue.main.async {
                if let index = self.tasks.firstIndex(where: { $0.id == task.id }) {
                    self.tasks[index] = task
                    completion(.success(()))
                }
                else {
                    completion(.failure(ServerError(message: "Unable to update task with id: \(task.id)")))
                }
            }
        }
    }
    
    func updateEmployee(_ employee: Employee, _ completion: @escaping ((Result<Void, Error>) -> Void)) {
        DispatchQueue.global(qos: .background).asyncAfter(deadline: .now() + stubDelay) {
            
            DispatchQueue.main.async {
                if let index = self.employees.firstIndex(where: { $0.id == employee.id }) {
                    self.employees[index] = employee
                    completion(.success(()))
                }
                else {
                    completion(.failure(ServerError(message: "Unable to update employee with id: \(employee.id)")))
                }
            }
        }
    }
}
