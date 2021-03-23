import Foundation
import CustardKit

let flick_greek = Custard(
    identifier: "flick_greek",
    language: .el_GR,
    input_style: .direct,
    metadata: .init(custard_version: .v1_0, display_name: "ギリシャ語フリック"),
    interface: .init(
        keyStyle: .tenkeyStyle,
        keyLayout: .gridFit(.init(rowCount: 5, columnCount: 4)),
        keys: [
            .gridFit(.init(x: 0, y: 0)): .system(.flick_star123_tab),
            .gridFit(.init(x: 0, y: 1)): .custom(
                .init(
                    design: .init(label: .text("αβγ"), color: .selected),
                    press_actions: [.moveTab(.custom("flick_greek"))],
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
                                design: .init(label: .text("abc")),
                                press_actions: [.moveTab(.system(.user_english))],
                                longpress_actions: .none)
                        )
                    ]
                )
            ),
            .gridFit(.init(x: 0, y: 2)): .system(.flick_hira_tab),
            .gridFit(.init(x: 0, y: 3)): .system(.change_keyboard),
            .gridFit(.init(x: 1, y: 0)): .custom(.flick_simple_inputs(center: "@", subs: ["#", "/", "&", "_"], centerLabel: "@#/&_")),
            .gridFit(.init(x: 2, y: 0)): .custom(.flick_simple_inputs(center: "α", subs: ["β", "γ"], centerLabel: "αβγ")),
            .gridFit(.init(x: 3, y: 0)): .custom(.flick_simple_inputs(center: "δ", subs: ["ε", "ζ"], centerLabel: "δεζ")),
            .gridFit(.init(x: 1, y: 1)): .custom(.flick_simple_inputs(center: "η", subs: ["θ", "ι"], centerLabel: "ηθι")),
            .gridFit(.init(x: 2, y: 1)): .custom(.flick_simple_inputs(center: "κ", subs: ["λ", "μ"], centerLabel: "κλμ")),
            .gridFit(.init(x: 3, y: 1)): .custom(.flick_simple_inputs(center: "ν", subs: ["ξ", "ο"], centerLabel: "νξο")),
            .gridFit(.init(x: 1, y: 2)): .custom(.flick_simple_inputs(center: "π", subs: ["ρ", "σ", "ς"], centerLabel: "πρσς")),
            .gridFit(.init(x: 2, y: 2)): .custom(.flick_simple_inputs(center: "τ", subs: ["υ", "φ"], centerLabel: "τυφ")),
            .gridFit(.init(x: 3, y: 2)): .custom(.flick_simple_inputs(center: "χ", subs: ["ψ", "ω"], centerLabel: "χψω")),
            .gridFit(.init(x: 1, y: 3)): .custom(
                .init(
                    design: .init(label: .text("a/A"), color: .normal),
                    press_actions: [.replaceDefault],
                    longpress_actions: .none,
                    variations: [
                        .init(
                            type: .flickVariation(.right),
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
                            type: .flickVariation(.top),
                            key: .init(
                                design: .init(label: .systemImage("shift.fill")),
                                press_actions: [.toggleCapsLockState],
                                longpress_actions: .none
                            )
                        ),
                    ]
                )
            ),
            .gridFit(.init(x: 2, y: 3)): .custom(.flick_simple_inputs(center: "'", subs: ["\"", "(", ")"], centerLabel: "'\"()")),
            .gridFit(.init(x: 3, y: 3)): .custom(.flick_simple_inputs(center: ".", subs: [",", ";", "!"], centerLabel: ".,;!")),
            .gridFit(.init(x: 4, y: 0)): .custom(.flick_delete),
            .gridFit(.init(x: 4, y: 1)): .custom(.flick_space),
            .gridFit(.init(x: 4, y: 2, width: 1, height: 2)): .system(.enter),
        ]
    )
)

do {
    try flick_greek.write(to: URL(fileURLWithPath: "../results/greek.json"))
} catch {
    print(error.localizedDescription)
}
