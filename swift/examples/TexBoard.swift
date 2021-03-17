import Foundation
import CustardKit

let tex_tab = Custard(
    custard_version: .v1_0,
    identifier: "tex_board",
    display_name: "tex",
    language: .none,
    input_style: .direct,
    interface: .init(
        keyStyle: .tenkeyStyle,
        keyLayout: .gridFit(.init(rowCount: 5, columnCount: 4)),
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
                            type: .flickVariation(.right),
                            key: .init(
                                design: .init(label: .text("→")),
                                press_actions: [.moveCursor(1)],
                                longpress_actions: .init(repeat: [.moveCursor(1)])
                            )
                        ),
                        .init(
                            type: .flickVariation(.top),
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
                            type: .flickVariation(.left),
                            key: .init(
                                design: .init(label: .text("2")),
                                press_actions: [.input("2")],
                                longpress_actions: .none
                            )
                        ),
                        .init(
                            type: .flickVariation(.top),
                            key: .init(
                                design: .init(label: .text("3")),
                                press_actions: [.input("3")],
                                longpress_actions: .none
                            )
                        ),
                        .init(
                            type: .flickVariation(.right),
                            key: .init(
                                design: .init(label: .text("4")),
                                press_actions: [.input("4")],
                                longpress_actions: .none
                            )
                        ),
                        .init(
                            type: .flickVariation(.bottom),
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
                            type: .flickVariation(.left),
                            key: .init(
                                design: .init(label: .text("7")),
                                press_actions: [.input("7")],
                                longpress_actions: .none
                            )
                        ),
                        .init(
                            type: .flickVariation(.top),
                            key: .init(
                                design: .init(label: .text("8")),
                                press_actions: [.input("8")],
                                longpress_actions: .none
                            )
                        ),
                        .init(
                            type: .flickVariation(.right),
                            key: .init(
                                design: .init(label: .text("9")),
                                press_actions: [.input("9")],
                                longpress_actions: .none
                            )
                        ),
                        .init(
                            type: .flickVariation(.bottom),
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
                            type: .flickVariation(.left),
                            key: .init(
                                design: .init(label: .text("()")),
                                press_actions: [.input("\\left(\\right)"), .moveCursor(-7)],
                                longpress_actions: .none
                            )
                        ),
                        .init(
                            type: .flickVariation(.top),
                            key: .init(
                                design: .init( label: .text("^")),
                                press_actions: [.input("^")],
                                longpress_actions: .none
                            )
                        ),
                        .init(
                            type: .flickVariation(.right),
                            key: .init(
                                design: .init(label: .text("\\{\\}")),
                                press_actions: [.input("\\{\\}")],
                                longpress_actions: .none
                            )
                        ),
                        .init(
                            type: .flickVariation(.bottom),
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
                            type: .flickVariation(.left),
                            key: .init(
                                design: .init(label: .text("\\")),
                                press_actions: [.input("\\")],
                                longpress_actions: .none
                            )
                        ),
                        .init(
                            type: .flickVariation(.top),
                            key: .init(
                                design: .init(label: .text("~")),
                                press_actions: [.input("~")],
                                longpress_actions: .none
                            )
                        ),
                        .init(
                            type: .flickVariation(.right),
                            key: .init(
                                design: .init(label: .text("/")),
                                press_actions: [.input("/")],
                                longpress_actions: .none
                            )
                        ),
                        .init(
                            type: .flickVariation(.bottom),
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
                            type: .flickVariation(.left),
                            key: .init(
                                design: .init(label: .text("±")),
                                press_actions: [.input("\\pm")],
                                longpress_actions: .none
                            )
                        ),
                        .init(
                            type: .flickVariation(.top),
                            key: .init(
                                design: .init(label: .text("-")),
                                press_actions: [.input("-")],
                                longpress_actions: .none
                            )
                        ),
                        .init(
                            type: .flickVariation(.right),
                            key: .init(
                                design: .init(label: .text("∓")),
                                press_actions: [.input("\\mp")],
                                longpress_actions: .none
                            )
                        ),
                        .init(
                            type: .flickVariation(.bottom),
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
                            type: .flickVariation(.left),
                            key: .init(
                                design: .init(label: .text("⟨⟩")),
                                press_actions: [.input("\\left\\langle\\right\\rangle"), .moveCursor(-13)],
                                longpress_actions: .none
                            )
                        ),
                        .init(
                            type: .flickVariation(.top),
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
                            type: .flickVariation(.left),
                            key: .init(
                                design: .init(label: .text("∂")),
                                press_actions: [.input("\\part")],
                                longpress_actions: .none
                            )
                        ),
                        .init(
                            type: .flickVariation(.top),
                            key: .init(
                                design: .init( label: .text("∬")),
                                press_actions: [.input("\\iint")],
                                longpress_actions: .none
                            )
                        ),
                        .init(
                            type: .flickVariation(.right),
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
                            type: .flickVariation(.left),
                            key: .init(
                                design: .init(label: .text("lim")),
                                press_actions: [.input("\\lim_{}"), .moveCursor(-1)],
                                longpress_actions: .none
                            )
                        ),
                        .init(
                            type: .flickVariation(.top),
                            key: .init(
                                design: .init(label: .text("log")),
                                press_actions: [.input("\\log_{}"), .moveCursor(-1)],
                                longpress_actions: .none
                            )
                        ),
                        .init(
                            type: .flickVariation(.right),
                            key: .init(
                                design: .init(label: .text("√")),
                                press_actions: [.input("\\sqrt{}"), .moveCursor(-1)],
                                longpress_actions: .none
                            )
                        ),
                        .init(
                            type: .flickVariation(.bottom),
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
                            type: .flickVariation(.left),
                            key: .init(
                                design: .init(label: .text("<")),
                                press_actions: [.input("<")],
                                longpress_actions: .none
                            )
                        ),
                        .init(
                            type: .flickVariation(.top),
                            key: .init(
                                design: .init(label: .text("≠")),
                                press_actions: [.input("\\ne")],
                                longpress_actions: .none
                            )
                        ),
                        .init(
                            type: .flickVariation(.right),
                            key: .init(
                                design: .init(label: .text(">")),
                                press_actions: [.input(">")],
                                longpress_actions: .none
                            )
                        ),
                        .init(
                            type: .flickVariation(.bottom),
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
                    design: .init(label: .systemImage("bold.italic.underline"), color: .normal),
                    press_actions: [.input("{\\bf }"), .moveCursor(-1)],
                    longpress_actions: .none,
                    variations: [
                        .init(
                            type: .flickVariation(.left),
                            key: .init(
                                design: .init(label: .text("rm")),
                                press_actions: [.input("{\\rm }"), .moveCursor(-1)],
                                longpress_actions: .none
                            )
                        ),
                        .init(
                            type: .flickVariation(.top),
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
                            type: .flickVariation(.left),
                            key: .init(
                                design: .init(label: .text("∞")),
                                press_actions: [.input("\\infty")],
                                longpress_actions: .none
                            )
                        ),
                        .init(
                            type: .flickVariation(.top),
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
                            type: .flickVariation(.left),
                            key: .init(
                                design: .init(label: .text(",")),
                                press_actions: [.input(",")],
                                longpress_actions: .none
                            )
                        ),
                        .init(
                            type: .flickVariation(.top),
                            key: .init(
                                design: .init(label: .text("?")),
                                press_actions: [.input("?")],
                                longpress_actions: .none
                            )
                        ),
                        .init(
                            type: .flickVariation(.right),
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
                    design: .init(label: .systemImage("delete.left"), color: .special),
                    press_actions: [.delete(1)],
                    longpress_actions: .init(repeat: [.delete(1)]),
                    variations: [
                        .init(
                            type: .flickVariation(.left),
                            key: .init(
                                design: .init(label: .systemImage("xmark")),
                                press_actions: [.smartDeleteDefault],
                                longpress_actions: .none
                            )
                        ),
                        .init(
                            type: .flickVariation(.bottom),
                            key: .init(
                                design: .init(label: .systemImage("delete.right")),
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
                            type: .flickVariation(.left),
                            key: .init(
                                design: .init(label: .text("←")),
                                press_actions: [.moveCursor(-1)],
                                longpress_actions: .init(repeat: [.moveCursor(-1)])
                            )
                        ),
                        .init(
                            type: .flickVariation(.top),
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
    try tex_tab.write(to: URL(fileURLWithPath: "../results/tex.json"))
} catch {
    print(error.localizedDescription)
}
