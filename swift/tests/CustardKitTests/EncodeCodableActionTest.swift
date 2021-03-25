import XCTest
@testable import CustardKit


///Test class for encoding of `CodableActionData`
///Make sure that decoding of `CodablaActionData` is successfuly working
final class EncodeCodableActionTest: XCTestCase {
    private func quickEncode(target: CodableActionData) -> Data? {
        let encoder = JSONEncoder()
        let encoded = try? encoder.encode(target)
        return encoded
    }

    private func quickDecode(target: Data?) -> CodableActionData? {
        let decoder = JSONDecoder()
        let decoded = try? decoder.decode(CodableActionData.self, from: target ?? Data())
        return decoded
    }

    private func quickEncodeDecode(target: CodableActionData) -> CodableActionData? {
        return quickDecode(target: quickEncode(target: target))
    }

    func testEncodeInput() {
        XCTAssertEqual(quickEncodeDecode(target: .input("😆")), .input("😆"))
        XCTAssertEqual(quickEncodeDecode(target: .input("\u{13000}")), .input("\u{13000}"))
        XCTAssertEqual(quickEncodeDecode(target: .input("\u{FFFFE}")), .input("\u{FFFFE}"))
    }

    func testEncodeReplaceLastCharacters() {
        XCTAssertEqual(quickEncodeDecode(target: .replaceLastCharacters([:])), .replaceLastCharacters([:]))
        let target: CodableActionData = .replaceLastCharacters([
            "天": "地",
            "海": "山",
            "正": "負",
            "嬉": "悲"
        ])
        XCTAssertEqual(quickEncodeDecode(target: target), target)
    }

    func testEncodeDelete() {
        XCTAssertEqual(quickEncodeDecode(target: .delete(9)), .delete(9))
        XCTAssertEqual(quickEncodeDecode(target: .delete(-1)), .delete(-1))
    }

    func testEncodeSmartDelete() {
        do{
            let target = CodableActionData.smartDelete(.init(targets: ["_"], direction: .backward))
            XCTAssertEqual(quickEncodeDecode(target: target), target)
        }
        do{
            let target = CodableActionData.smartDelete()
            XCTAssertEqual(quickEncodeDecode(target: target), target)
        }
    }

    func testEncodeMoveCursor() {
        XCTAssertEqual(quickEncodeDecode(target: .moveCursor(9)), .moveCursor(9))
        XCTAssertEqual(quickEncodeDecode(target: .moveCursor(-1)), .moveCursor(-1))
    }

    func testEncodeSmartMoveCursor() {
        do{
            let target = CodableActionData.smartDelete(.init(targets: ["…"], direction: .backward))
            XCTAssertEqual(quickEncodeDecode(target: target), target)
        }
        do{
            let target = CodableActionData.smartDelete()
            XCTAssertEqual(quickEncodeDecode(target: target), target)
        }
    }

    func testEncodeMoveTab() {
        XCTAssertEqual(quickEncodeDecode(target: .moveTab(.custom("flick_greek"))), .moveTab(.custom("flick_greek")))
        XCTAssertEqual(quickEncodeDecode(target: .moveTab(.system(.flick_numbersymbols))), .moveTab(.system(.flick_numbersymbols)))
    }

    func testEncodeNoArgumentActions() {
        XCTAssertEqual(quickEncodeDecode(target: .replaceDefault), .replaceDefault)
        XCTAssertEqual(quickEncodeDecode(target: .smartDeleteDefault), .smartDeleteDefault)
        XCTAssertEqual(quickEncodeDecode(target: .complete), .complete)
        XCTAssertEqual(quickEncodeDecode(target: .enableResizingMode), .enableResizingMode)
        XCTAssertEqual(quickEncodeDecode(target: .toggleCursorBar), .toggleCursorBar)
        XCTAssertEqual(quickEncodeDecode(target: .toggleTabBar), .toggleTabBar)
        XCTAssertEqual(quickEncodeDecode(target: .toggleCapsLockState), .toggleCapsLockState)
        XCTAssertEqual(quickEncodeDecode(target: .dismissKeyboard), .dismissKeyboard)
    }

    static var allTests = [
        ("testEncodeInput", testEncodeInput),
        ("testEncodeDelete", testEncodeDelete),
        ("testEncodeReplaceLastCharacters", testEncodeReplaceLastCharacters),
        ("testEncodeSmartDelete", testEncodeSmartDelete),
        ("testEncodeMoveCursor", testEncodeMoveCursor),
        ("testEncodeSmartMoveCursor", testEncodeSmartMoveCursor),
        ("testEncodeMoveTab", testEncodeMoveTab),
        ("testEncodeNoArgumentActions", testEncodeNoArgumentActions)
    ]
}
