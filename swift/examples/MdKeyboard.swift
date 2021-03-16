import Foundation
import CustardKit

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
    try md_custard.write(to: URL(fileURLWithPath: "../results/md_keyboard.json"))
} catch {
    print(error.localizedDescription)
}
