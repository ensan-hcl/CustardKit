import XCTest
@testable import CustardKit

final class CustardLogicsTest: XCTestCase {
    func testDecode() {
        do{
            let target = """
            {
                "initial_values": [
                    {
                        "name": "state_x",
                        "type": "string",
                        "value": "✋"
                    },
                    {
                        "name": "is_y",
                        "type": "bool",
                        "value": true
                    }
                ]
            }
            """
            XCTAssertEqual(CustardLogics.quickDecode(target: target), .init(initialValues: [.init(name: "state_x", value: .string("✋")), .init(name: "is_y", value: .bool(true))]))
        }
    }

    func testEncode() {
        do{
            let target = CustardLogics(initialValues: [.init(name: "s", value: .string("f"))])
            XCTAssertEqual(target.quickEncodeDecode(), target)
        }
        do{
            let target = CustardLogics(initialValues: [])
            XCTAssertEqual(target.quickEncodeDecode(), target)
        }
    }

    static var allTests = [
        ("testDecode", testDecode),
        ("testEncode", testEncode)
    ]
}
