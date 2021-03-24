import XCTest
@testable import CustardKit

final class CustardKitTests: XCTestCase {
    func testCustardVersion() {
        XCTAssertEqual(CustardVersion.v1_0.rawValue, "1.0")
    }

    static var allTests = [
        ("testCustardVersion", testCustardVersion),
    ]
}
