import XCTest
@testable import CustardKit

final class CustardKeyLabelStyleTest: XCTestCase {
    func testDecode() {
        do{
            let target = """
            {"text": "HaTa"}
            """
            XCTAssertEqual(CustardKeyLabelStyle.quickDecode(target: target), .text("HaTa"))
        }
        do{
            let target = """
            {"system_image": "aris_to_teles"}
            """
            XCTAssertEqual(CustardKeyLabelStyle.quickDecode(target: target), .systemImage("aris_to_teles"))
        }
        do{
            let target = """
            {"systemimage": "aris_to_teles"}
            """
            XCTAssertEqual(CustardKeyLabelStyle.quickDecode(target: target), nil)
        }
        do {
            let target = """
            {"main_and_variations": "1"}
            """
            XCTAssertEqual(CustardKeyLabelStyle.quickDecode(target: target), nil)
        }
        do {
            let target = """
            {"type": "text", "text": "turing"}
            """
            XCTAssertEqual(CustardKeyLabelStyle.quickDecode(target: target), .text("turing"))
        }
        do {
            let target = """
            {"type": "system_image", "system_image": "que"}
            """
            XCTAssertEqual(CustardKeyLabelStyle.quickDecode(target: target), .systemImage("que"))
        }
        do {
            let target = """
            {"type": "main_and_variations", "main": "1", "variations": "☆♡◇"}
            """
            XCTAssertEqual(CustardKeyLabelStyle.quickDecode(target: target), .mainAndVariations("1", "☆♡◇"))
        }
    }

    func testEncode() {
        do{
            let target = CustardKeyLabelStyle.text("omiya")
            XCTAssertEqual(target.quickEncodeDecode(), target)
        }
        do{
            let target = CustardKeyLabelStyle.systemImage("kitanitatuya")
            XCTAssertEqual(target.quickEncodeDecode(), target)
        }
        do{
            let target = CustardKeyLabelStyle.mainAndVariations("金", "money")
            XCTAssertEqual(target.quickEncodeDecode(), target)
        }
    }

    static var allTests = [
        ("testDecode", testDecode),
        ("testEncode", testEncode)
    ]
}
