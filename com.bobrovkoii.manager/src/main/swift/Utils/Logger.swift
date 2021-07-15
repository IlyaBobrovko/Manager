import Foundation

/**
 Error logger.
 */
class Logger {
    
    /**
     Log error using NSLog.
     
     - Parameters:
        - error: Error.
     */
    static func logError(_ error: Error) {
        if let baseError = error as? BaseError {
            NSLog(baseError.message)
        }
        else {
            NSLog(error.localizedDescription)
        }
    }
}
