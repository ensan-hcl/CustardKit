import XCTest
@testable import CustardKit

final class ConstantsTest: XCTestCase {
    func testCustardVersion() {
        XCTAssertEqual(CustardVersion.v1_0.rawValue, "1.0")
    }

    func testFlickDirection() {
        XCTAssertEqual(FlickDirection.left.rawValue, "left")
        XCTAssertEqual(FlickDirection.top.rawValue, "top")
        XCTAssertEqual(FlickDirection.right.rawValue, "right")
        XCTAssertEqual(FlickDirection.bottom.rawValue, "bottom")
    }

    static var allTests = [
        ("testCustardVersion", testCustardVersion),
        ("testFlickDirection", testFlickDirection),
    ]
}
