import XCTest
import UIKit
@testable import trainingtask

class TextValidatorTestCase: XCTestCase {
    
    let textValidator = TextValidator()

    func testTextValidation_notEmptyName_passValidation() {
        let text = "Billy"
        
        XCTAssert(textValidator.notEmpty(text))
    }
    
    func testTextValidation_emptyString_noPassValidation() {
        let text = ""
        
        XCTAssertFalse(textValidator.notEmpty(text))
    }
    
    func testTextValidation_stringOfSpaces_noPassValidation() {
        let text = "    "
        
        XCTAssertFalse(textValidator.notEmpty(text))
    }
}
