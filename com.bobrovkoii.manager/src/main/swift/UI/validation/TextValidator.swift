import UIKit

/**
 Text validation.
 */
class TextValidator {
    
    /**
     Validation for empty string.
     
     - Parameters:
        - strings: String.
     - Returns: True if string without spaces not empty, overwisw fasle.
     */
    func notEmpty(_ string: String) -> Bool {
        var set = CharacterSet(charactersIn: string)
        set.subtract(CharacterSet.whitespaces)
        
        return !set.isEmpty
    }
}
