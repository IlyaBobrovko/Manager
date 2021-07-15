import Foundation

/**
 Settings model.
 */
class Settings: Codable {
    
    /**
     URL server.
     */
    var url: String
    
    /**
     Elements count.
     */
    var elementsCount: Int
    
    /**
     Days count.
     */
    var daysCount: Int
    
    /**
     Setting initialization.
     
     - Parameters:
        - url: URL server.
        - elementCount: Element count.
        - daysCount: Days count.
     */
    init(url: String, elementCount: Int, daysCount: Int) {
        self.url = url
        self.elementsCount = elementCount
        self.daysCount = daysCount
    }
}
