import XCTest
@testable import CustardKit


final class CodableLongpressActionTest: XCTestCase {
    func testDecodeLongpressAction() {
        let target = """
            {
                "start": [{
                    "type": "input",
                    "text": "ブルーホール"
                }],
                "repeat": [{
                    "type": "input",
                    "text": "青"
                }]
            }
            """
        let decoded = CodableLongpressActionData.quickDecode(target: target)
        XCTAssertEqual(decoded, .init(start: [.input("ブルーホール")], repeat: [.input("青")]))
    }

    func testEncodeLongpressAction() {
        let target = CodableLongpressActionData.init(start: [.complete, .dismissKeyboard, .moveCursor(-1)], repeat: [.moveCursor(-1)])
        XCTAssertEqual(target.quickEncodeDecode(), target)
    }

    func testStaticValue() {
        let target = CodableLongpressActionData.none
        XCTAssertEqual(target, CodableLongpressActionData.init(start: [], repeat: []))
    }

    static var allTests = [
        ("testDecodeLongpressAction", testDecodeLongpressAction),
        ("testEncodeLongpressAction", testEncodeLongpressAction),
        ("testStaticValue", testStaticValue)
    ]
}
