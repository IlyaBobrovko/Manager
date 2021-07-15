import UIKit

/**
 Number validation.
 */
class NumberValidator {
    
    private let zero = 0
    
    /**
     Validation for a positive number.
     
     - Parameters:
        - integer: Integer.
     - Returns: True if number is positive, otherwise false.
     */
    func isPositive(_ integer: Int) -> Bool {
        return integer > zero
    }
}
