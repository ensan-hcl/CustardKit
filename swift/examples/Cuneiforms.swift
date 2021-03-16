import Foundation
import CustardKit

let cuneiforms = Array(String.UnicodeScalarView((UInt32(0x12480)...UInt32(0x12543)).compactMap(UnicodeScalar.init))).map(String.init)

let keys: [CustardKeyPositionSpecifier: CustardInterfaceKey] = [
    .gridScroll(0): .system(.change_keyboard),
    .gridScroll(1): .custom(
        .init(
            design: .init(label: .text("←"), color: .special),
            press_actions: [.moveCursor(-1)],
            longpress_actions: .init(repeat: [.moveCursor(-1)]),
            variations: []
        )
    ),
    .gridScroll(2): .custom(
        .init(
            design: .init(label: .text("→"), color: .special),
            press_actions: [.moveCursor(1)],
            longpress_actions: .init(repeat: [.moveCursor(1)]),
            variations: []
        )
    ),
    .gridScroll(3): .custom(
        .init(
            design: .init(label: .system_image("list.bullet"), color: .special),
            press_actions: [.toggleTabBar],
            longpress_actions: .none,
            variations: []
        )
    ),
    .gridScroll(4): .custom(
        .init(
            design: .init(label: .system_image("delete.left"), color: .special),
            press_actions: [.delete(1)],
            longpress_actions: .init(repeat: [.delete(1)]),
            variations: []
        )
    ),
]

var cuneiforms_keys = keys
cuneiforms.indices.forEach{
    cuneiforms_keys[.gridScroll(GridScrollPositionSpecifier(cuneiforms_keys.count))] = .custom(
        .init(
            design: .init(label: .text(cuneiforms[$0]), color: .normal),
            press_actions: [.input(cuneiforms[$0])],
            longpress_actions: .none,
            variations: []
        )
    )
}

let cuneiforms_custard = Custard(
    custard_version: .v1_0,
    identifier: "Cuneiforms",
    display_name: "楔形文字",
    language: .none,
    input_style: .direct,
    interface: .init(
        key_style: .tenkeyStyle,
        key_layout: .gridScroll(.init(direction: .vertical, rowCount: 8, columnCount: 4.2)),
        keys: cuneiforms_keys
    )
)
do {
    try cuneiforms_custard.write(to: URL(fileURLWithPath: "../results/cuneiforms.json"))
} catch {
    print(error.localizedDescription)
}
