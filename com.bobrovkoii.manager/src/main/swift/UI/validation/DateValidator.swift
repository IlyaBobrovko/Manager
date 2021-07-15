import Foundation

/**
 Date validation.
 */
class DateValidator {
    
    private let dateFormatter = DateFormatter()

    /**
     Validate string as date.
     
     - Parameters:
        - date: String.
     - Returns: True if string can converted to a date, overwise false.
     */
    func isValid(_ date: String) -> Bool {
        dateFormatter.dateFormat = "YYYY-MM-DD"
        return dateFormatter.date(from: date) != nil
    }
}
