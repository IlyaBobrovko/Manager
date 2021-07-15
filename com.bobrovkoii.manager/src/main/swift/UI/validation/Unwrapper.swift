import Foundation

/**
 Optional unwrapper.
 */
class Unwrapper {
    
    /**
     Unwrap optional type. Returns unwrapped value, overwise throws unwrapper error.
     
     - Parameters:
        - item: Optional value.
     - Throws: Unwrapper error if value unable to be unwrapped.
     - Returns: Unwrapped value.
     */
    func unwrap<Type>(_ item: Type?) throws -> Type {
        if let item = item {
            return item
        }
        else {
            throw UnwrapperError(message: "Unable to unwrap type: \(Type.self)")
        }
    }
}
