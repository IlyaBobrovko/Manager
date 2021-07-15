import Foundation

/**
 Base error type.
 */
class BaseError: Error {
        
    /**
     Error message.
     */
    var message: String
    
    /**
     Error cause.
     */
    var cause: Error?
    
    /**
     BaseError initializer.
     
     - Parameters:
        - message: Error message.
        - cause: Error cause.
     */
    init(message: String, cause: Error? = nil) {
        self.message = message
        self.cause = cause
    }
}
