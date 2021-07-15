import Foundation

/**
 Task status cases.
 */
enum TaskStatus: CaseIterable {
    
    /**
     Task not started.
     */
    case notStarted
    
    /**
     Task in progress.
     */
    case active
    
    /**
     Task completed.
     */
    case completed
    
    /**
     Task postponed.
     */
    case postponed
}
