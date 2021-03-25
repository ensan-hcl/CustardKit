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
    }

    static var allTests = [
        ("testDecode", testDecode),
        ("testEncode", testEncode)
    ]
}
