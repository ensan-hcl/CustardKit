import XCTest
@testable import CustardKit


///Test class for encoding of `CodableActionData`
///Make sure that decoding of `CodablaActionData` is successfuly working
final class EncodeCodableActionTest: XCTestCase {
    func testEncodeInput() {
        XCTAssertEqual(CodableActionData.input("😆").quickEncodeDecode(), .input("😆"))
        XCTAssertEqual(CodableActionData.input("\u{13000}").quickEncodeDecode(), .input("\u{13000}"))
        XCTAssertEqual(CodableActionData.input("\u{FFFFE}").quickEncodeDecode(), .input("\u{FFFFE}"))
    }

    func testEncodeReplaceLastCharacters() {
        XCTAssertEqual(CodableActionData.replaceLastCharacters([:]).quickEncodeDecode(), .replaceLastCharacters([:]))
        let target: CodableActionData = .replaceLastCharacters([
            "天": "地",
            "海": "山",
            "正": "負",
            "嬉": "悲"
        ])
        XCTAssertEqual(target.quickEncodeDecode(), target)
    }

    func testEncodeDelete() {
        XCTAssertEqual(CodableActionData.delete(9).quickEncodeDecode(), .delete(9))
        XCTAssertEqual(CodableActionData.delete(-1).quickEncodeDecode(), .delete(-1))
    }

    func testEncodeSmartDelete() {
        do{
            let target = CodableActionData.smartDelete(.init(targets: ["_"], direction: .backward))
            XCTAssertEqual(target.quickEncodeDecode(), target)
        }
        do{
            let target = CodableActionData.smartDelete()
            XCTAssertEqual(target.quickEncodeDecode(), target)
        }
    }

    func testEncodeMoveCursor() {
        XCTAssertEqual(CodableActionData.moveCursor(9).quickEncodeDecode(), .moveCursor(9))
        XCTAssertEqual(CodableActionData.moveCursor(-1).quickEncodeDecode(), .moveCursor(-1))
    }

    func testEncodeSmartMoveCursor() {
        do{
            let target = CodableActionData.smartDelete(.init(targets: ["…"], direction: .backward))
            XCTAssertEqual(target.quickEncodeDecode(), target)
        }
        do{
            let target = CodableActionData.smartDelete()
            XCTAssertEqual(target.quickEncodeDecode(), target)
        }
    }

    func testEncodeMoveTab() {
        XCTAssertEqual(CodableActionData.moveTab(.custom("flick_greek")).quickEncodeDecode(), .moveTab(.custom("flick_greek")))
        XCTAssertEqual(CodableActionData.moveTab(.system(.flick_numbersymbols)).quickEncodeDecode(), .moveTab(.system(.flick_numbersymbols)))
    }

    func testEncodeSetActions() {
        XCTAssertEqual(CodableActionData.setCursorBar(.toggle).quickEncodeDecode(), .setCursorBar(.toggle))
        XCTAssertEqual(CodableActionData.setCapsLockState(.off).quickEncodeDecode(), .setCapsLockState(.off))
        XCTAssertEqual(CodableActionData.setTabBar(.on).quickEncodeDecode(), .setTabBar(.on))
        XCTAssertEqual(CodableActionData.setBoolState(state: "snabo", value: "not(false)").quickEncodeDecode(), .setBoolState(state: "snabo", value: "not(false)"))
    }

    func testEncodeBoolSwitchAction() {
        do{
            let target = CodableActionData.boolSwitch(
                condition: "not(is_pressed_x and is_pressed_y) and (state_z == 'normal')",
                trueActions: [
                    .input("「」"),
                    .moveCursor(-1)
                ],
                falseActions: [
                    .boolSwitch(
                        condition: "is_caps_locked",
                        trueActions: [
                            .input("A"),
                        ],
                        falseActions: [
                            .delete(1),
                            .complete
                        ]
                    )
                ]
            )
            XCTAssertEqual(target.quickEncodeDecode(), target)
        }
    }

    func testEncodeNoArgumentActions() {
        XCTAssertEqual(CodableActionData.replaceDefault.quickEncodeDecode(), .replaceDefault)
        XCTAssertEqual(CodableActionData.smartDeleteDefault.quickEncodeDecode(), .smartDeleteDefault)
        XCTAssertEqual(CodableActionData.complete.quickEncodeDecode(), .complete)
        XCTAssertEqual(CodableActionData.enableResizingMode.quickEncodeDecode(), .enableResizingMode)
        XCTAssertEqual(CodableActionData.dismissKeyboard.quickEncodeDecode(), .dismissKeyboard)
    }

    func testEncodeDeprecatedActions() {
        // Replaced to alternatives
        XCTAssertEqual(CodableActionData.toggleCursorBar.quickEncodeDecode(), .setCursorBar(.toggle))
        XCTAssertEqual(CodableActionData.toggleTabBar.quickEncodeDecode(), .setTabBar(.toggle))
        XCTAssertEqual(CodableActionData.toggleCapsLockState.quickEncodeDecode(), .setCapsLockState(.toggle))
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
