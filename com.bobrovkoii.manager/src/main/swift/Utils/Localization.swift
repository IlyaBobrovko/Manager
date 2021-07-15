import Foundation

/**
 Localization service.
 */
class Localization {
    
    /**
     Returns a localized string.
     
     - Parameters:
        - key: String key.
     - Returns: Localized string.
     */
    static func localize(key: String) -> String {
        return NSLocalizedString(key, comment: "")
    }
}
