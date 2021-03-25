import XCTest
@testable import CustardKit

final class CustardInterfaceCustomKeyTest: XCTestCase {
    func testDecode() {
        do{
            let target = """
            {
                "design": {"label":{"text": "潔白"}, "color": "special"},
                "press_actions": [{
                    "type": "input",
                    "text": "面白",
                }],
                "longpress_actions": {
                    "start": [{
                        "type": "input",
                        "text": "蛋白",
                    }],
                    "repeat": [{
                        "type": "input",
                        "text": "腕白",
                    }]
                },
                "variations": []
            }
            """
            XCTAssertEqual(
                CustardInterfaceCustomKey.quickDecode(target: target),
                .init(
                    design: .init(label: .text("潔白"), color: .special),
                    press_actions: [.input("面白")],
                    longpress_actions: .init(start: [.input("蛋白")], repeat: [.input("腕白")]),
                    variations: []
                )
            )
        }
    }

    func testEncode() {
        do{
            let target = CustardInterfaceCustomKey.flickSpace()
            XCTAssertEqual(target.quickEncodeDecode(), target)
        }
        do{
            let target = CustardInterfaceCustomKey.flickDelete()
            XCTAssertEqual(target.quickEncodeDecode(), target)
        }
    }

    func testStaticKeys() {
        do{
            let target = CustardInterfaceCustomKey.flickSpace()
            XCTAssertEqual(target.design, .init(label: .text("空白"), color: .special))
            XCTAssertEqual(target.press_actions, [.input(" ")])
            XCTAssertEqual(target.longpress_actions, .init(start: [.toggleCursorBar]))
            XCTAssertEqual(target.variations.count, 3)
        }
        do{
            let target = CustardInterfaceCustomKey.flickDelete()
            XCTAssertEqual(target.design, .init(label: .systemImage("delete.left"), color: .special))
            XCTAssertEqual(target.press_actions, [.delete(1)])
            XCTAssertEqual(target.longpress_actions, .init(repeat: [.delete(1)]))
            XCTAssertEqual(target.variations.count, 1)
        }
    }

    func testFlickSimpleInputs() {
        do{
            let target = CustardInterfaceCustomKey.flickSimpleInputs(center: "💛", subs: ["💙","🖤","🧡"])
            XCTAssertEqual(target.design, .init(label: .text("💛"), color: .normal))
            XCTAssertEqual(target.press_actions, [.input("💛")])
            XCTAssertEqual(target.longpress_actions, .none)
            XCTAssertEqual(target.variations.count, 3)

            XCTAssertEqual(target.variations[0].type, .flickVariation(.left))
            XCTAssertEqual(target.variations[0].key.design, .init(label: .text("💙")))
            XCTAssertEqual(target.variations[0].key.press_actions, [.input("💙")])
            XCTAssertEqual(target.variations[0].key.longpress_actions, .none)

            XCTAssertEqual(target.variations[1].type, .flickVariation(.top))
            XCTAssertEqual(target.variations[1].key.design, .init(label: .text("🖤")))
            XCTAssertEqual(target.variations[1].key.press_actions, [.input("🖤")])
            XCTAssertEqual(target.variations[1].key.longpress_actions, .none)

            XCTAssertEqual(target.variations[2].type, .flickVariation(.right))
            XCTAssertEqual(target.variations[2].key.design, .init(label: .text("🧡")))
            XCTAssertEqual(target.variations[2].key.press_actions, [.input("🧡")])
            XCTAssertEqual(target.variations[2].key.longpress_actions, .none)
        }
        do{
            let target = CustardInterfaceCustomKey.flickSimpleInputs(center: "💛", subs: ["💙","🖤","🧡"], centerLabel: "ハート")
            XCTAssertEqual(target.design, .init(label: .text("ハート"), color: .normal))
            XCTAssertEqual(target.press_actions, [.input("💛")])
        }
    }


    static var allTests = [
        ("testDecode", testDecode),
        ("testEncode", testEncode),
        ("testStaticKeys", testStaticKeys),
        ("testFlickSimpleInputs", testFlickSimpleInputs),
    ]
}
