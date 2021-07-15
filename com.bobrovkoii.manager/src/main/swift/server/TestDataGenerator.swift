import Foundation

/**
 Test date generator.
 */
class TestDataGenerator {
    
    static private var lastIdentifier = 0
    
    /**
     Generate new identifier.
     
     - Returns: Identifier.
     */
    func generateIdentifier() -> Int {
        TestDataGenerator.lastIdentifier += 1
        return TestDataGenerator.lastIdentifier
    }
    
    /**
     Generate test projects.
     
     - Returns: Test projects.
     */
    func testProjects() -> [Project] {
        return [
            Project(id: generateIdentifier(), name: "Project #1", detail: "Description #1"),
            Project(id: generateIdentifier(), name: "Project #2", detail: "Description #2"),
            Project(id: generateIdentifier(), name: "Project #3", detail: "Description #3")
        ]
    }
    
    /**
     Generate test tasks.
     
     - Returns: Test tasks.
     */
    func testTasks() -> [Task] {
        let result = [
            Task(id: generateIdentifier(),
                 name: "Task #1",
                 workTime: 31,
                 startDate: Date(),
                 finishDate: Date(),
                 status: .notStarted),
            
            Task(id: generateIdentifier(),
                 name: "Task #2",
                 workTime: 4,
                 startDate: Date(),
                 finishDate: Date(),
                 status: .active),
            
            Task(id: generateIdentifier(),
                 name: "Task #3",
                 workTime: 24,
                 startDate: Date(),
                 finishDate: Date(),
                 status: .postponed),
            
            Task(id: generateIdentifier(),
                 name: "Task #4",
                 workTime: 33,
                 startDate: Date(),
                 finishDate: Date(),
                 status: .completed),
            
            Task(id: generateIdentifier(),
                 name: "Task #5",
                 workTime: 40,
                 startDate: Date(),
                 finishDate: Date(),
                 status: .notStarted)
        ]
        return result
    }
    
    /**
     Generate test employees.
     
     - Returns: Test employees.
     */
    func testEmployees() -> [Employee] {
        return [
            Employee(id: generateIdentifier(), name: "Alex", surname: "Alex", middleName: "Alex", post: "Post #1"),
            Employee(id: generateIdentifier(), name: "Max", surname: "Max", middleName: "Max", post: "Post #2"),
            Employee(id: generateIdentifier(), name: "Rob", surname: "Rob", middleName: "Rob", post: "Post #3"),
            Employee(id: generateIdentifier(), name: "Josh", surname: "Josh", middleName: "Josh", post: "Post #4"),
            Employee(id: generateIdentifier(), name: "Luke", surname: "Luke", middleName: "Luke", post: "Post #5")
        ]
    }
}
