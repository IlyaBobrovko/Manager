import XCTest
import UIKit
@testable import trainingtask

class NameValidatorTest: XCTestCase {
    
    let nameValidator: Validator = NameValidator()

    func testNameValidation_validName_passValidation() {
        let name = "Billy"
        
        XCTAssert(nameValidator.validate(name))
    }
    
    func testNameValidation_emptyString_noPassValidation() {
        let name = ""
        
        XCTAssertFalse(nameValidator.validate(name))
    }
    
    func testNameValidation_stringOfSpaces_noPassValidation() {
        let name = "    "
        
        XCTAssertFalse(nameValidator.validate(name))
    }

    func testNameValidation_nilString_noPassValidation() {
        let name: String? = nil
        
        XCTAssertFalse(nameValidator.validate(name))
    }
}
