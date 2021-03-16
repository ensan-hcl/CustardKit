import Foundation
import CustardKit

let hieroglyphs = String.UnicodeScalarView((UInt32(0x13000)...UInt32(0x133FF)).compactMap(UnicodeScalar.init)).map(String.init)

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

var hieroglyphs_keys = keys
hieroglyphs.indices.forEach{
    hieroglyphs_keys[.gridScroll(GridScrollPositionSpecifier(5+$0))] = .custom(
        .init(
            design: .init(label: .text(hieroglyphs[$0]), color: .normal),
            press_actions: [.input(hieroglyphs[$0])],
            longpress_actions: .none,
            variations: []
        )
    )
}

let hieroglyphs_custard = Custard(
    custard_version: .v1_0,
    identifier: "Hieroglyphs",
    display_name: "ヒエログリフ",
    language: .none,
    input_style: .direct,
    interface: .init(
        key_style: .tenkeyStyle,
        key_layout: .gridScroll(.init(direction: .vertical, rowCount: 8, columnCount: 4.2)),
        keys: hieroglyphs_keys
    )
)

let encoder = JSONEncoder()
let decoder = JSONDecoder()
do {
    try hieroglyphs_custard.write(to: URL(fileURLWithPath: "./results/hieroglyphs.custard"))
} catch {
    print(error.localizedDescription)
}

let cuneiforms = Array(String.UnicodeScalarView((UInt32(0x12480)...UInt32(0x12543)).compactMap(UnicodeScalar.init))).map(String.init)

var cuneiforms_keys = keys
cuneiforms.indices.forEach{
    cuneiforms_keys[.gridScroll(GridScrollPositionSpecifier(5+$0))] = .custom(
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
    try cuneiforms_custard.write(to: URL(fileURLWithPath: "./results/cuneiforms.custard"))
} catch {
    print(error.localizedDescription)
}

func makeKey(main: String, sub: [String]?) -> CustardInterfaceKey {
    if let sub = sub{
        return .custom(
            .init(
                design: .init(label: .text(main), color: .normal),
                press_actions: [.input(main)],
                longpress_actions: .none,
                variations: [
                    .init(type: .flick_variation(.left), key: .init(design: .init(label: .text(sub[0])), press_actions: [.input(sub[0])], longpress_actions: .none)),
                    .init(type: .flick_variation(.top), key: .init(design: .init(label: .text(sub[1])), press_actions: [.input(sub[1])], longpress_actions: .none)),
                    .init(type: .flick_variation(.right), key: .init(design: .init(label: .text(sub[2])), press_actions: [.input(sub[2])], longpress_actions: .none)),
                    .init(type: .flick_variation(.bottom), key: .init(design: .init(label: .text(sub[3])), press_actions: [.input(sub[3])], longpress_actions: .none))
                ])
        )}
    else{
        return .custom(
            .init(
                design: .init(label: .text(main), color: .normal),
                press_actions: [.input(main)],
                longpress_actions: .none,
                variations: [])
        )
    }
}

let md_custard = Custard(
    custard_version: .v1_0,
    identifier: "md_keyboard_jp",
    display_name: "日本語markdownキーボード",
    language: .ja_JP,
    input_style: .direct,
    interface: .init(
        key_style: .tenkeyStyle,
        key_layout: .gridFit(.init(rowCount: 6, columnCount: 4)),
        keys: [
            .gridFit(.init(x: 0, y: 0)): .custom(
                .init(
                    design: .init(label: .text("123"), color: .special),
                    press_actions: [.moveTab(.system(.flick_numbersymbols))],
                    longpress_actions: .init(start: [.toggleTabBar]),
                    variations: []
                )
            ),
            .gridFit(.init(x: 0, y: 1)): .custom(
                .init(
                    design: .init(label: .text("abc"), color: .special),
                    press_actions: [.moveTab(.system(.user_english))],
                    longpress_actions: .none,
                    variations: [
                        .init(
                            type: .flick_variation(.right),
                            key: .init(
                                design: .init(label: .text("→")),
                                press_actions: [.moveCursor(1)],
                                longpress_actions: .init(repeat: [.moveCursor(1)])
                            )
                        )
                    ]
                )
            ),
            .gridFit(.init(x: 0, y: 2)): .custom(
                .init(
                    design: .init(label: .text("あいう"), color: .special),
                    press_actions: [.moveTab(.system(.user_japanese))],
                    longpress_actions: .none,
                    variations: []
                )
            ),
            .gridFit(.init(x: 0, y: 3)): .system(.change_keyboard),
            .gridFit(.init(x: 1, y: 0)): makeKey(main: "あ", sub: ["い", "う", "え", "お"]),
            .gridFit(.init(x: 2, y: 0)): makeKey(main: "か", sub: ["き", "く", "け", "こ"]),
            .gridFit(.init(x: 3, y: 0)): makeKey(main: "さ", sub: ["し", "す", "せ", "そ"]),
            .gridFit(.init(x: 1, y: 1)): makeKey(main: "た", sub: ["ち", "つ", "て", "と"]),
            .gridFit(.init(x: 2, y: 1)): makeKey(main: "な", sub: ["に", "ぬ", "ね", "の"]),
            .gridFit(.init(x: 3, y: 1)): makeKey(main: "は", sub: ["ひ", "ふ", "へ", "ほ"]),
            .gridFit(.init(x: 1, y: 2)): makeKey(main: "ま", sub: ["み", "む", "め", "も"]),
            .gridFit(.init(x: 2, y: 2)): makeKey(main: "や", sub: ["「", "ゆ", "」", "よ"]),
            .gridFit(.init(x: 3, y: 2)): makeKey(main: "ら", sub: ["り", "る", "れ", "ろ"]),
            .gridFit(.init(x: 1, y: 3)): .system(.flick_kogaki),
            .gridFit(.init(x: 2, y: 3)): makeKey(main: "わ", sub: ["を", "ん", "ー", ""]),
            .gridFit(.init(x: 3, y: 3)): makeKey(main: "、", sub: ["。", "！", "？", ""]),
            .gridFit(.init(x: 4, y: 0)): .custom(
                .init(
                    design: .init(label: .system_image("bold"), color: .special),
                    press_actions: [.input("****"), .moveCursor(-2)],
                    longpress_actions: .none,
                    variations: [
                        .init(
                            type: .flick_variation(.left),
                            key: .init(
                                design: .init(label: .system_image("italic")),
                                press_actions: [.input("**"), .moveCursor(-1)],
                                longpress_actions: .none
                            )
                        ),
                        .init(
                            type: .flick_variation(.top),
                            key: .init(
                                design: .init(label: .system_image("strikethrough")),
                                press_actions: [.input("~~~~"), .moveCursor(-2)],
                                longpress_actions: .none
                            )
                        ),
                        .init(
                            type: .flick_variation(.right),
                            key: .init(
                                design: .init(label: .text("√π")),
                                press_actions: [.input("$$"), .moveCursor(-1)],
                                longpress_actions: .none
                            )
                        ),
                        .init(
                            type: .flick_variation(.bottom),
                            key: .init(
                                design: .init(label: .text("𝚖𝚘𝚗𝚘")),
                                press_actions: [.input("``"), .moveCursor(-1)],
                                longpress_actions: .none
                            )
                        ),
                    ]
                )
            ),
            .gridFit(.init(x: 4, y: 1)): .custom(
                .init(
                    design: .init(label: .system_image("link"), color: .special),
                    press_actions: [.input("[]()"), .moveCursor(-3)],
                    longpress_actions: .none,
                    variations: [
                        .init(
                            type: .flick_variation(.left),
                            key: .init(
                                design: .init(label: .text("*")),
                                press_actions: [.input("*")],
                                longpress_actions: .none
                            )
                        ),
                        .init(
                            type: .flick_variation(.top),
                            key: .init(
                                design: .init(label: .text(".")),
                                press_actions: [.input(".")],
                                longpress_actions: .none
                            )
                        ),
                        .init(
                            type: .flick_variation(.right),
                            key: .init(
                                design: .init(label: .text("-")),
                                press_actions: [.input("-")],
                                longpress_actions: .none
                            )
                        ),
                    ]
                )
            ),
            .gridFit(.init(x: 4, y: 2)): .custom(
                .init(
                    design: .init(label: .text("見出し"), color: .special),
                    press_actions: [.input("# ")],
                    longpress_actions: .none,
                    variations: [
                        .init(
                            type: .flick_variation(.left),
                            key: .init(
                                design: .init(label: .text("見出し2")),
                                press_actions: [.input("## ")],
                                longpress_actions: .none
                            )
                        ),
                        .init(
                            type: .flick_variation(.top),
                            key: .init(
                                design: .init(label: .text("見出し3")),
                                press_actions: [.input("### ")],
                                longpress_actions: .none
                            )
                        ),
                        .init(
                            type: .flick_variation(.right),
                            key: .init(
                                design: .init(label: .text("見出し4")),
                                press_actions: [.input("#### ")],
                                longpress_actions: .none
                            )
                        ),
                        .init(
                            type: .flick_variation(.bottom),
                            key: .init(
                                design: .init(label: .text("見出し5")),
                                press_actions: [.input("##### ")],
                                longpress_actions: .none
                            )
                        ),

                    ]
                )
            ),
            .gridFit(.init(x: 4, y: 3)): .custom(
                .init(
                    design: .init(label: .text("```"), color: .special),
                    press_actions: [.input("```\n\n```"), .moveCursor(-5)],
                    longpress_actions: .none,
                    variations: []
                )
            ),
            .gridFit(.init(x: 5, y: 0)): .custom(
                .init(
                    design: .init(label: .system_image("delete.left"), color: .special),
                    press_actions: [.delete(1)],
                    longpress_actions: .init(repeat: [.delete(1)]),
                    variations: [
                        .init(
                            type: .flick_variation(.left),
                            key: .init(
                                design: .init(label: .system_image("xmark")),
                                press_actions: [.smartDeleteDefault],
                                longpress_actions: .none
                            )
                        ),
                        .init(
                            type: .flick_variation(.bottom),
                            key: .init(
                                design: .init(label: .system_image("delete.right")),
                                press_actions: [.delete(-1)],
                                longpress_actions: .init(repeat: [.moveCursor(-1)])
                            )
                        )
                    ]
                )
            ),
            .gridFit(.init(x: 5, y: 1)): .custom(
                .init(
                    design: .init(label: .text("空白"), color: .special),
                    press_actions: [.input(" ")],
                    longpress_actions: .init(start: [.toggleCursorBar]),
                    variations: [
                        .init(
                            type: .flick_variation(.left),
                            key: .init(
                                design: .init(label: .text("←")),
                                press_actions: [.moveCursor(-1)],
                                longpress_actions: .init(repeat: [.moveCursor(-1)])
                            )
                        ),
                        .init(
                            type: .flick_variation(.top),
                            key: .init(
                                design: .init(label: .text("\t")),
                                press_actions: [.moveCursor(-1)],
                                longpress_actions: .none
                            )
                        )
                    ]
                )
            ),
            .gridFit(.init(x: 5, y: 2)): .custom(
                .init(
                    design: .init(label: .system_image("list.bullet"), color: .special),
                    press_actions: [.toggleTabBar],
                    longpress_actions: .none,
                    variations: []
                )
            ),
            .gridFit(.init(x: 5, y: 2, width: 1, height: 2)): .system(.enter),
        ]
    )
)
do {
    try md_custard.write(to: URL(fileURLWithPath: "./results/md_keyboard.custard"))
} catch {
    print(error.localizedDescription)
}


let tex_tab = Custard(
    custard_version: .v1_0,
    identifier: "tex_board",
    display_name: "tex",
    language: .none,
    input_style: .direct,
    interface: .init(
        key_style: .tenkeyStyle,
        key_layout: .gridFit(.init(rowCount: 5, columnCount: 4)),
        keys: [
            .gridFit(.init(x: 0, y: 0)): .custom(
                .init(
                    design: .init(label: .text("☆123"), color: .special),
                    press_actions: [.moveTab(.system(.flick_numbersymbols))],
                    longpress_actions: .init(start: [.toggleTabBar]),
                    variations: []
                )
            ),
            .gridFit(.init(x: 0, y: 1)): .custom(
                .init(
                    design: .init(label: .text("abc"), color: .special),
                    press_actions: [.moveTab(.system(.user_english))],
                    longpress_actions: .none,
                    variations: [
                        .init(
                            type: .flick_variation(.right),
                            key: .init(
                                design: .init(label: .text("→")),
                                press_actions: [.moveCursor(1)],
                                longpress_actions: .init(repeat: [.moveCursor(1)])
                            )
                        ),
                        .init(
                            type: .flick_variation(.top),
                            key: .init(
                                design: .init(label: .text("αβγ")),
                                press_actions: [.moveTab(.custom("latex_greek"))],
                                longpress_actions: .none
                            )
                        )
                    ]
                )
            ),
            .gridFit(.init(x: 0, y: 2)): .custom(
                .init(
                    design: .init(label: .text("あいう"), color: .special),
                    press_actions: [.moveTab(.system(.user_japanese))],
                    longpress_actions: .none,
                    variations: []
                )
            ),
            .gridFit(.init(x: 0, y: 3)): .system(.change_keyboard),

            .gridFit(.init(x: 1, y: 0)): .custom(
                .init(
                    design: .init(label: .text("12345"), color: .normal),
                    press_actions: [.input("1")],
                    longpress_actions: .none,
                    variations: [
                        .init(
                            type: .flick_variation(.left),
                            key: .init(
                                design: .init(label: .text("2")),
                                press_actions: [.input("2")],
                                longpress_actions: .none
                            )
                        ),
                        .init(
                            type: .flick_variation(.top),
                            key: .init(
                                design: .init(label: .text("3")),
                                press_actions: [.input("3")],
                                longpress_actions: .none
                            )
                        ),
                        .init(
                            type: .flick_variation(.right),
                            key: .init(
                                design: .init(label: .text("4")),
                                press_actions: [.input("4")],
                                longpress_actions: .none
                            )
                        ),
                        .init(
                            type: .flick_variation(.bottom),
                            key: .init(
                                design: .init( label: .text("5")),
                                press_actions: [.input("5")],
                                longpress_actions: .none
                            )
                        )
                    ]
                )
            ),
            .gridFit(.init(x: 2, y: 0)): .custom(
                .init(
                    design: .init(label: .text("67890"), color: .normal),
                    press_actions: [.input("6")],
                    longpress_actions: .none,
                    variations: [
                        .init(
                            type: .flick_variation(.left),
                            key: .init(
                                design: .init(label: .text("7")),
                                press_actions: [.input("7")],
                                longpress_actions: .none
                            )
                        ),
                        .init(
                            type: .flick_variation(.top),
                            key: .init(
                                design: .init(label: .text("8")),
                                press_actions: [.input("8")],
                                longpress_actions: .none
                            )
                        ),
                        .init(
                            type: .flick_variation(.right),
                            key: .init(
                                design: .init(label: .text("9")),
                                press_actions: [.input("9")],
                                longpress_actions: .none
                            )
                        ),
                        .init(
                            type: .flick_variation(.bottom),
                            key: .init(
                                design: .init(label: .text("0")),
                                press_actions: [.input("0")],
                                longpress_actions: .none
                            )
                        )
                    ]
                )
            ),
            .gridFit(.init(x: 3, y: 0)): .custom(
                .init(
                    design: .init(label: .text("(^/_]"), color: .normal),
                    press_actions: [.input("\\frac{}{}"), .moveCursor(-3)],
                    longpress_actions: .none,
                    variations: [
                        .init(
                            type: .flick_variation(.left),
                            key: .init(
                                design: .init(label: .text("()")),
                                press_actions: [.input("\\left(\\right)"), .moveCursor(-7)],
                                longpress_actions: .none
                            )
                        ),
                        .init(
                            type: .flick_variation(.top),
                            key: .init(
                                design: .init( label: .text("^")),
                                press_actions: [.input("^")],
                                longpress_actions: .none
                            )
                        ),
                        .init(
                            type: .flick_variation(.right),
                            key: .init(
                                design: .init(label: .text("\\{\\}")),
                                press_actions: [.input("\\{\\}")],
                                longpress_actions: .none
                            )
                        ),
                        .init(
                            type: .flick_variation(.bottom),
                            key: .init(
                                design: .init(label: .text("_")),
                                press_actions: [.input("_")],
                                longpress_actions: .none
                            )
                        )
                    ]
                )
            ),
            .gridFit(.init(x: 1, y: 1)): .custom(
                .init(
                    design: .init(label: .text("\\&/"), color: .normal),
                    press_actions: [.input("&")],
                    longpress_actions: .none,
                    variations: [
                        .init(
                            type: .flick_variation(.left),
                            key: .init(
                                design: .init(label: .text("\\")),
                                press_actions: [.input("\\")],
                                longpress_actions: .none
                            )
                        ),
                        .init(
                            type: .flick_variation(.top),
                            key: .init(
                                design: .init(label: .text("~")),
                                press_actions: [.input("~")],
                                longpress_actions: .none
                            )
                        ),
                        .init(
                            type: .flick_variation(.right),
                            key: .init(
                                design: .init(label: .text("/")),
                                press_actions: [.input("/")],
                                longpress_actions: .none
                            )
                        ),
                        .init(
                            type: .flick_variation(.bottom),
                            key: .init(
                                design: .init(label: .text("|")),
                                press_actions: [.input("|")],
                                longpress_actions: .none
                            )
                        ),
                    ]
                )
            ),

            .gridFit(.init(x: 2, y: 1)): .custom(
                .init(
                    design: .init(label: .text("+-×"), color: .normal),
                    press_actions: [.input("+")],
                    longpress_actions: .none,
                    variations: [
                        .init(
                            type: .flick_variation(.left),
                            key: .init(
                                design: .init(label: .text("±")),
                                press_actions: [.input("\\pm")],
                                longpress_actions: .none
                            )
                        ),
                        .init(
                            type: .flick_variation(.top),
                            key: .init(
                                design: .init(label: .text("-")),
                                press_actions: [.input("-")],
                                longpress_actions: .none
                            )
                        ),
                        .init(
                            type: .flick_variation(.right),
                            key: .init(
                                design: .init(label: .text("∓")),
                                press_actions: [.input("\\mp")],
                                longpress_actions: .none
                            )
                        ),
                        .init(
                            type: .flick_variation(.bottom),
                            key: .init(
                                design: .init(label: .text("×")),
                                press_actions: [.input("\\times")],
                                longpress_actions: .none
                            )
                        )
                    ]
                )
            ),
            .gridFit(.init(x: 3, y: 1)): .custom(
                .init(
                    design: .init(label: .text("{}"), color: .normal),
                    press_actions: [.input("{}"), .moveCursor(-1)],
                    longpress_actions: .none,
                    variations: [
                        .init(
                            type: .flick_variation(.left),
                            key: .init(
                                design: .init(label: .text("⟨⟩")),
                                press_actions: [.input("\\left\\langle\\right\\rangle"), .moveCursor(-13)],
                                longpress_actions: .none
                            )
                        ),
                        .init(
                            type: .flick_variation(.top),
                            key: .init(
                                design: .init(label: .text("[]")),
                                press_actions: [.input("\\left[\\right]"), .moveCursor(-7)],
                                longpress_actions: .none
                            )
                        ),
                    ]
                )
            ),
            .gridFit(.init(x: 1, y: 2)): .custom(
                .init(
                    design: .init(label: .text("∫"), color: .normal),
                    press_actions: [.input("\\int^{}_{}"), .moveCursor(-4)],
                    longpress_actions: .none,
                    variations: [
                        .init(
                            type: .flick_variation(.left),
                            key: .init(
                                design: .init(label: .text("∂")),
                                press_actions: [.input("\\part")],
                                longpress_actions: .none
                            )
                        ),
                        .init(
                            type: .flick_variation(.top),
                            key: .init(
                                design: .init( label: .text("∬")),
                                press_actions: [.input("\\iint")],
                                longpress_actions: .none
                            )
                        ),
                        .init(
                            type: .flick_variation(.right),
                            key: .init(
                                design: .init(label: .text("∮")),
                                press_actions: [.input("\\oint")],
                                longpress_actions: .none
                            )
                        ),
                    ]
                )
            ),
            .gridFit(.init(x: 2, y: 2)): .custom(
                .init(
                    design: .init(label: .text("Σ"), color: .normal),
                    press_actions: [.input("\\sum^{}_{}"), .moveCursor(-4)],
                    longpress_actions: .none,
                    variations: [
                        .init(
                            type: .flick_variation(.left),
                            key: .init(
                                design: .init(label: .text("lim")),
                                press_actions: [.input("\\lim_{}"), .moveCursor(-1)],
                                longpress_actions: .none
                            )
                        ),
                        .init(
                            type: .flick_variation(.top),
                            key: .init(
                                design: .init(label: .text("log")),
                                press_actions: [.input("\\log_{}"), .moveCursor(-1)],
                                longpress_actions: .none
                            )
                        ),
                        .init(
                            type: .flick_variation(.right),
                            key: .init(
                                design: .init(label: .text("√")),
                                press_actions: [.input("\\sqrt{}"), .moveCursor(-1)],
                                longpress_actions: .none
                            )
                        ),
                        .init(
                            type: .flick_variation(.bottom),
                            key: .init(
                                design: .init(label: .text("√")),
                                press_actions: [.input("\\sqrt[]{}"), .moveCursor(-3)],
                                longpress_actions: .none
                            )
                        ),
                    ]
                )
            ),
            .gridFit(.init(x: 3, y: 2)): .custom(
                .init(
                    design: .init(label: .text("="), color: .normal),
                    press_actions: [.input("=")],
                    longpress_actions: .none,
                    variations: [
                        .init(
                            type: .flick_variation(.left),
                            key: .init(
                                design: .init(label: .text("<")),
                                press_actions: [.input("<")],
                                longpress_actions: .none
                            )
                        ),
                        .init(
                            type: .flick_variation(.top),
                            key: .init(
                                design: .init(label: .text("≠")),
                                press_actions: [.input("\\ne")],
                                longpress_actions: .none
                            )
                        ),
                        .init(
                            type: .flick_variation(.right),
                            key: .init(
                                design: .init(label: .text(">")),
                                press_actions: [.input(">")],
                                longpress_actions: .none
                            )
                        ),
                        .init(
                            type: .flick_variation(.bottom),
                            key: .init(
                                design: .init(label: .text("≡")),
                                press_actions: [.input("\\equiv")],
                                longpress_actions: .none
                            )
                        ),
                    ]
                )
            ),
            .gridFit(.init(x: 1, y: 3)): .custom(
                .init(
                    design: .init(label: .system_image("bold.italic.underline"), color: .normal),
                    press_actions: [.input("{\\bf }"), .moveCursor(-1)],
                    longpress_actions: .none,
                    variations: [
                        .init(
                            type: .flick_variation(.left),
                            key: .init(
                                design: .init(label: .text("rm")),
                                press_actions: [.input("{\\rm }"), .moveCursor(-1)],
                                longpress_actions: .none
                            )
                        ),
                        .init(
                            type: .flick_variation(.top),
                            key: .init(
                                design: .init(label: .text("mathbb")),
                                press_actions: [.input("\\mathbb ")],
                                longpress_actions: .none
                            )
                        ),
                    ]
                )
            ),
            .gridFit(.init(x: 2, y: 3)): .custom(
                .init(
                    design: .init(label: .text("π∞∅"), color: .normal),
                    press_actions: [.input("\\pi")],
                    longpress_actions: .none,
                    variations: [
                        .init(
                            type: .flick_variation(.left),
                            key: .init(
                                design: .init(label: .text("∞")),
                                press_actions: [.input("\\infty")],
                                longpress_actions: .none
                            )
                        ),
                        .init(
                            type: .flick_variation(.top),
                            key: .init(
                                design: .init(label: .text("∅")),
                                press_actions: [.input("\\empty ")],
                                longpress_actions: .none
                            )
                        ),
                    ]
                )
            ),
            .gridFit(.init(x: 3, y: 3)): .custom(
                .init(
                    design: .init(label: .text(".,!?"), color: .normal),
                    press_actions: [.input(".")],
                    longpress_actions: .none,
                    variations: [
                        .init(
                            type: .flick_variation(.left),
                            key: .init(
                                design: .init(label: .text(",")),
                                press_actions: [.input(",")],
                                longpress_actions: .none
                            )
                        ),
                        .init(
                            type: .flick_variation(.top),
                            key: .init(
                                design: .init(label: .text("?")),
                                press_actions: [.input("?")],
                                longpress_actions: .none
                            )
                        ),
                        .init(
                            type: .flick_variation(.right),
                            key: .init(
                                design: .init(label: .text("!")),
                                press_actions: [.input("!")],
                                longpress_actions: .none
                            )
                        ),
                    ]
                )
            ),
            .gridFit(.init(x: 4, y: 0)): .custom(
                .init(
                    design: .init(label: .system_image("delete.left"), color: .special),
                    press_actions: [.delete(1)],
                    longpress_actions: .init(repeat: [.delete(1)]),
                    variations: [
                        .init(
                            type: .flick_variation(.left),
                            key: .init(
                                design: .init(label: .system_image("xmark")),
                                press_actions: [.smartDeleteDefault],
                                longpress_actions: .none
                            )
                        ),
                        .init(
                            type: .flick_variation(.bottom),
                            key: .init(
                                design: .init(label: .system_image("delete.right")),
                                press_actions: [.delete(-1)],
                                longpress_actions: .init(repeat: [.delete(-1)])
                            )
                        )
                    ]
                )
            ),
            .gridFit(.init(x: 4, y: 1)): .custom(
                .init(
                    design: .init(label: .text("空白"), color: .special),
                    press_actions: [.input(" ")],
                    longpress_actions: .init(start: [.toggleCursorBar]),
                    variations: [
                        .init(
                            type: .flick_variation(.left),
                            key: .init(
                                design: .init(label: .text("←")),
                                press_actions: [.moveCursor(-1)],
                                longpress_actions: .init(repeat: [.moveCursor(-1)])
                            )
                        ),
                        .init(
                            type: .flick_variation(.top),
                            key: .init(
                                design: .init(label: .text("\t")),
                                press_actions: [.moveCursor(-1)],
                                longpress_actions: .none
                            )
                        )
                    ]
                )
            ),
            .gridFit(.init(x: 4, y: 2, width: 1, height: 2)): .system(.enter),

        ]
    )
)
do {
    try tex_tab.write(to: URL(fileURLWithPath: "./results/tex.custard"))
} catch {
    print(error.localizedDescription)
}

let flick_greek = Custard(
    custard_version: .v1_0,
    identifier: "flick_greek",
    display_name: "ギリシャ語フリック",
    language: .el_GR,
    input_style: .direct,
    interface: .init(
        key_style: .tenkeyStyle,
        key_layout: .gridFit(.init(rowCount: 5, columnCount: 4)),
        keys: [
            .gridFit(.init(x: 0, y: 0)): .custom(
                .init(
                    design: .init(label: .text("☆123"), color: .special),
                    press_actions: [.moveTab(.system(.flick_numbersymbols))],
                    longpress_actions: .init(start: [.toggleTabBar]),
                    variations: []
                )
            ),
            .gridFit(.init(x: 0, y: 1)): .custom(
                .init(
                    design: .init(label: .text("αβγ"), color: .selected),
                    press_actions: [.moveTab(.custom("flick_greek"))],
                    longpress_actions: .none,
                    variations: [
                        .init(
                            type: .flick_variation(.right),
                            key: .init(
                                design: .init(label: .text("→")),
                                press_actions: [.moveCursor(1)],
                                longpress_actions: .init(repeat: [.moveCursor(1)])
                            )
                        ),
                        .init(
                            type: .flick_variation(.top),
                            key: .init(
                                design: .init(label: .text("abc")),
                                press_actions: [.moveTab(.system(.user_english))],
                                longpress_actions: .none)
                        )
                    ]
                )
            ),
            .gridFit(.init(x: 0, y: 2)): .custom(
                .init(
                    design: .init(label: .text("あいう"), color: .special),
                    press_actions: [.moveTab(.system(.user_japanese))],
                    longpress_actions: .none,
                    variations: []
                )
            ),
            .gridFit(.init(x: 0, y: 3)): .system(.change_keyboard),
            .gridFit(.init(x: 1, y: 0)): .custom(
                .init(
                    design: .init(label: .text("@#/&_"), color: .normal),
                    press_actions: [.input("@")],
                    longpress_actions: .none,
                    variations: [
                        .init(
                            type: .flick_variation(.left),
                            key: .init(
                                design: .init(label: .text("#")),
                                press_actions: [.input("#")],
                                longpress_actions: .none
                            )
                        ),
                        .init(
                            type: .flick_variation(.top),
                            key: .init(
                                design: .init(label: .text("/")),
                                press_actions: [.input("/")],
                                longpress_actions: .none
                            )
                        ),
                        .init(
                            type: .flick_variation(.right),
                            key: .init(
                                design: .init(label: .text("&")),
                                press_actions: [.input("&")],
                                longpress_actions: .none
                            )
                        ),
                        .init(
                            type: .flick_variation(.bottom),
                            key: .init(
                                design: .init(label: .text("_")),
                                press_actions: [.input("_")],
                                longpress_actions: .none
                            )
                        ),
                    ]
                )
            ),

            .gridFit(.init(x: 2, y: 0)): .custom(
                .init(
                    design: .init(label: .text("αβγ"), color: .normal),
                    press_actions: [.input("α")],
                    longpress_actions: .none,
                    variations: [
                        .init(
                            type: .flick_variation(.left),
                            key: .init(
                                design: .init(label: .text("β")),
                                press_actions: [.input("β")],
                                longpress_actions: .none
                            )
                        ),
                        .init(
                            type: .flick_variation(.top),
                            key: .init(
                                design: .init(label: .text("γ")),
                                press_actions: [.input("γ")],
                                longpress_actions: .none
                            )
                        ),
                    ]
                )
            ),
            .gridFit(.init(x: 3, y: 0)): .custom(
                .init(
                    design: .init(label: .text("δεζ"), color: .normal),
                    press_actions: [.input("δ")],
                    longpress_actions: .none,
                    variations: [
                        .init(
                            type: .flick_variation(.left),
                            key: .init(
                                design: .init(label: .text("ε")),
                                press_actions: [.input("ε")],
                                longpress_actions: .none
                            )
                        ),
                        .init(
                            type: .flick_variation(.top),
                            key: .init(
                                design: .init(label: .text("ζ")),
                                press_actions: [.input("ζ")],
                                longpress_actions: .none
                            )
                        ),
                    ]
                )
            ),
            .gridFit(.init(x: 1, y: 1)): .custom(
                .init(
                    design: .init(label: .text("ηθι"), color: .normal),
                    press_actions: [.input("η")],
                    longpress_actions: .none,
                    variations: [
                        .init(
                            type: .flick_variation(.left),
                            key: .init(
                                design: .init(label: .text("θ")),
                                press_actions: [.input("θ")],
                                longpress_actions: .none
                            )
                        ),
                        .init(
                            type: .flick_variation(.top),
                            key: .init(
                                design: .init(label: .text("ι")),
                                press_actions: [.input("ι")],
                                longpress_actions: .none
                            )
                        ),
                    ]
                )
            ),
            .gridFit(.init(x: 2, y: 1)): .custom(
                .init(
                    design: .init(label: .text("κλμ"), color: .normal),
                    press_actions: [.input("κ")],
                    longpress_actions: .none,
                    variations: [
                        .init(
                            type: .flick_variation(.left),
                            key: .init(
                                design: .init(label: .text("λ")),
                                press_actions: [.input("λ")],
                                longpress_actions: .none
                            )
                        ),
                        .init(
                            type: .flick_variation(.top),
                            key: .init(
                                design: .init(label: .text("μ")),
                                press_actions: [.input("μ")],
                                longpress_actions: .none
                            )
                        ),
                    ]
                )
            ),

            .gridFit(.init(x: 3, y: 1)): .custom(
                .init(
                    design: .init(label: .text("νξο"), color: .normal),
                    press_actions: [.input("ν")],
                    longpress_actions: .none,
                    variations: [
                        .init(
                            type: .flick_variation(.left),
                            key: .init(
                                design: .init(label: .text("ξ")),
                                press_actions: [.input("ξ")],
                                longpress_actions: .none
                            )
                        ),
                        .init(
                            type: .flick_variation(.top),
                            key: .init(
                                design: .init(label: .text("ο")),
                                press_actions: [.input("ο")],
                                longpress_actions: .none
                            )
                        ),
                    ]
                )
            ),
            .gridFit(.init(x: 1, y: 2)): .custom(
                .init(
                    design: .init(label: .text("πρσς"), color: .normal),
                    press_actions: [.input("π")],
                    longpress_actions: .none,
                    variations: [
                        .init(
                            type: .flick_variation(.left),
                            key: .init(
                                design: .init(label: .text("ρ")),
                                press_actions: [.input("ρ")],
                                longpress_actions: .none
                            )
                        ),
                        .init(
                            type: .flick_variation(.top),
                            key: .init(
                                design: .init(label: .text("σ")),
                                press_actions: [.input("σ")],
                                longpress_actions: .none
                            )
                        ),
                        .init(
                            type: .flick_variation(.right),
                            key: .init(
                                design: .init( label: .text("ς")),
                                press_actions: [.input("ς")],
                                longpress_actions: .none
                            )
                        ),
                    ]
                )
            ),
            .gridFit(.init(x: 2, y: 2)): .custom(
                .init(
                    design: .init(label: .text("τυφ"), color: .normal),
                    press_actions: [.input("τ")],
                    longpress_actions: .none,
                    variations: [
                        .init(
                            type: .flick_variation(.left),
                            key: .init(
                                design: .init(label: .text("υ")),
                                press_actions: [.input("υ")],
                                longpress_actions: .none
                            )
                        ),
                        .init(
                            type: .flick_variation(.top),
                            key: .init(
                                design: .init(label: .text("φ")),
                                press_actions: [.input("φ")],
                                longpress_actions: .none
                            )
                        ),
                    ]
                )
            ),
            .gridFit(.init(x: 3, y: 2)): .custom(
                .init(
                    design: .init(label: .text("χψω"), color: .normal),
                    press_actions: [.input("χ")],
                    longpress_actions: .none,
                    variations: [
                        .init(
                            type: .flick_variation(.left),
                            key: .init(
                                design: .init(label: .text("ψ")),
                                press_actions: [.input("ψ")],
                                longpress_actions: .none
                            )
                        ),
                        .init(
                            type: .flick_variation(.top),
                            key: .init(
                                design: .init(label: .text("ω")),
                                press_actions: [.input("ω")],
                                longpress_actions: .none
                            )
                        ),
                    ]
                )
            ),
            .gridFit(.init(x: 1, y: 3)): .custom(
                .init(
                    design: .init(label: .text("a/A"), color: .normal),
                    press_actions: [.replaceDefault],
                    longpress_actions: .none,
                    variations: [
                        .init(
                            type: .flick_variation(.right),
                            key: .init(
                                design: .init(label: .text("´")),
                                press_actions: [.input("´"), .replaceLastCharacters([
                                    "ε´":"έ",
                                    "υ´":"ύ",
                                    "ι´":"ί",
                                    "ο´":"ό",
                                    "α´":"ά",
                                    "η´":"ή",
                                    "ω´":"ώ",
                                    "Ε´":"Έ",
                                    "Υ´":"Ύ",
                                    "Ι´":"Ί",
                                    "Ο´":"Ό",
                                    "Α´":"Ά",
                                    "Η´":"Ή",
                                    "Ω´":"Ώ"
                                ])],
                                longpress_actions: .none
                            )
                        ),
                        .init(
                            type: .flick_variation(.top),
                            key: .init(
                                design: .init(label: .system_image("shift.fill")),
                                press_actions: [.toggleCapslockState],
                                longpress_actions: .none
                            )
                        ),
                    ]
                )
            ),
            .gridFit(.init(x: 2, y: 3)): .custom(
                .init(
                    design: .init(label: .text("'\"()"), color: .normal),
                    press_actions: [.input("'")],
                    longpress_actions: .none,
                    variations: [
                        .init(
                            type: .flick_variation(.left),
                            key: .init(
                                design: .init(label: .text("\"")),
                                press_actions: [.input("\"")],
                                longpress_actions: .none
                            )
                        ),
                        .init(
                            type: .flick_variation(.top),
                            key: .init(
                                design: .init(label: .text("(")),
                                press_actions: [.input("(")],
                                longpress_actions: .none
                            )
                        ),
                        .init(
                            type: .flick_variation(.right),
                            key: .init(
                                design: .init(label: .text(")")),
                                press_actions: [.input(")")],
                                longpress_actions: .none
                            )
                        ),
                    ]
                )
            ),
            .gridFit(.init(x: 3, y: 3)): .custom(
                .init(
                    design: .init(label: .text(".,;!"), color: .normal),
                    press_actions: [.input(".")],
                    longpress_actions: .none,
                    variations: [
                        .init(
                            type: .flick_variation(.left),
                            key: .init(
                                design: .init(label: .text(",")),
                                press_actions: [.input(",")],
                                longpress_actions: .none
                            )
                        ),
                        .init(
                            type: .flick_variation(.top),
                            key: .init(
                                design: .init(label: .text(";")),
                                press_actions: [.input(";")],
                                longpress_actions: .none
                            )
                        ),
                        .init(
                            type: .flick_variation(.right),
                            key: .init(
                                design: .init(label: .text("!")),
                                press_actions: [.input("!")],
                                longpress_actions: .none
                            )
                        ),
                    ]
                )
            ),
            .gridFit(.init(x: 4, y: 0)): .custom(
                .init(
                    design: .init(label: .system_image("delete.left"), color: .special),
                    press_actions: [.delete(1)],
                    longpress_actions: .init(repeat: [.delete(1)]),
                    variations: [
                        .init(
                            type: .flick_variation(.left),
                            key: .init(
                                design: .init(label: .system_image("xmark")),
                                press_actions: [.smartDeleteDefault],
                                longpress_actions: .none
                            )
                        ),
                        .init(
                            type: .flick_variation(.bottom),
                            key: .init(
                                design: .init(label: .system_image("xmark")),
                                press_actions: [.smartMoveCursor(.init(targets: ["、","。","！","？",".",",","．","，", "\n"], direction: .backward))],
                                longpress_actions: .none
                            )
                        ),
                        .init(
                            type: .flick_variation(.top),
                            key: .init(
                                design: .init(label: .system_image("xmark")),
                                press_actions: [.smartMoveCursor(.init(targets: ["、","。","！","？",".",",","．","，", "\n"], direction: .forward))],
                                longpress_actions: .none
                            )
                        )
                    ]
                )
            ),
            .gridFit(.init(x: 4, y: 1)): .custom(
                .init(
                    design: .init(label: .text("空白"), color: .special),
                    press_actions: [.input(" ")],
                    longpress_actions: .init(start: [.toggleCursorBar]),
                    variations: [
                        .init(
                            type: .flick_variation(.left),
                            key: .init(
                                design: .init(label: .text("←")),
                                press_actions: [.moveCursor(-1)],
                                longpress_actions: .init(repeat: [.moveCursor(-1)])
                            )
                        ),
                        .init(
                            type: .flick_variation(.top),
                            key: .init(
                                design: .init(label: .text("\t")),
                                press_actions: [.moveCursor(-1)],
                                longpress_actions: .none
                            )
                        )
                    ]
                )
            ),
            .gridFit(.init(x: 4, y: 2, width: 1, height: 2)): .system(.enter),
        ]
    )
)

do {
    try flick_greek.write(to: URL(fileURLWithPath: "./results/greek.custard"))
} catch {
    print(error.localizedDescription)
}

let interesting_layout = Custard(
    custard_version: .v1_0,
    identifier: "direction",
    display_name: "方向",
    language: .none,
    input_style: .direct,
    interface: .init(
        key_style: .tenkeyStyle,
        key_layout: .gridFit(.init(rowCount: 5, columnCount: 4)),
        keys: [
            .gridFit(.init(x: 0, y: 0)): .custom(
                .init(
                    design: .init(label: .text("左上"), color: .normal),
                    press_actions: [.input("↖️")],
                    longpress_actions: .none,
                    variations: []
                )
            ),
            .gridFit(.init(x: 1, y: 0, width: 3, height: 1)): .custom(
                .init(
                    design: .init(label: .text("上"), color: .normal),
                    press_actions: [.input("⬆️")],
                    longpress_actions: .none,
                    variations: []
                )
            ),
            .gridFit(.init(x: 4, y: 0)): .custom(
                .init(
                    design: .init(label: .text("右上"), color: .normal),
                    press_actions: [.input("↗️")],
                    longpress_actions: .none,
                    variations: []
                )
            ),
            .gridFit(.init(x: 0, y: 1, width: 1, height: 2)): .custom(
                .init(
                    design: .init(label: .text("左"), color: .normal),
                    press_actions: [.input("⬅️")],
                    longpress_actions: .none,
                    variations: []
                )
            ),
            .gridFit(.init(x: 1, y: 1, width: 3, height: 2)): .custom(
                .init(
                    design: .init(label: .text("中央"), color: .normal),
                    press_actions: [.input("⏺")],
                    longpress_actions: .init(start: [.toggleTabBar]),
                    variations: []
                )
            ),
            .gridFit(.init(x: 4, y: 1, width: 1, height: 2)): .custom(
                .init(
                    design: .init(label: .text("右"), color: .normal),
                    press_actions: [.input("➡️")],
                    longpress_actions: .none,
                    variations: []
                )
            ),
            .gridFit(.init(x: 0, y: 3)): .custom(
                .init(
                    design: .init(label: .text("左下"), color: .normal),
                    press_actions: [.input("↙️")],
                    longpress_actions: .none,
                    variations: []
                )
            ),
            .gridFit(.init(x: 1, y: 3, width: 3, height: 1)): .custom(
                .init(
                    design: .init(label: .text("下"), color: .normal),
                    press_actions: [.input("⬇️")],
                    longpress_actions: .none,
                    variations: []
                )
            ),
            .gridFit(.init(x: 4, y: 3)): .custom(
                .init(
                    design: .init(label: .text("右下"), color: .normal),
                    press_actions: [.input("↘️")],
                    longpress_actions: .none,
                    variations: []
                )
            ),
        ]
    )
)
do {
    try interesting_layout.write(to: URL(fileURLWithPath: "./results/direction.custard"))
} catch {
    print(error.localizedDescription)
}
