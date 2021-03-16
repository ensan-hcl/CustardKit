import Foundation
import CustardKit

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
    try flick_greek.write(to: URL(fileURLWithPath: "../results/greek.json"))
} catch {
    print(error.localizedDescription)
}