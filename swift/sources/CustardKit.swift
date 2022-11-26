//
//  CustardKit.swift
//
//  Created by ensan on 2021/03/13.
//  Copyright © 2021 ensan. All rights reserved.
//

import Foundation

extension Encodable{
    func containerEncode<CodingKeys: CodingKey>(container: inout KeyedEncodingContainer<CodingKeys>, key: CodingKeys) throws {
        try container.encode(self, forKey: key)
    }
}

public enum FlickDirection: String, Codable {
    case left
    case top
    case right
    case bottom
}

/// - 変換対象の言語を指定します。
/// - specify language to convert
public enum CustardLanguage: String, Codable {
    /// - 英語(アメリカ)に変換します
    /// - convert to American English
    case en_US

    /// - 日本語(共通語)に変換します
    /// - convert to common Japanese
    case ja_JP

    /// - ギリシア語に変換します
    /// - convert to Greek
    case el_GR

    /// - 変換を行いません
    /// - don't convert
    case none

    /// - 特に変換する言語を指定しません
    /// - don't specify
    case undefined
}

/// - 入力方式を指定します。
/// - specify input style
public enum CustardInputStyle: String, Codable {
    /// - 入力された文字をそのまま用います
    /// - use inputted characters directly
    case direct

    /// - 入力されたローマ字を仮名に変換して用います
    /// - use roman-kana conversion
    case roman2kana
}

/// - カスタードのバージョンを指定します。
/// - specify custard version
public enum CustardVersion: String, Codable {
    case v1_0 = "1.0"
}

public struct CustardMetadata: Codable, Equatable {
    public init(custard_version: CustardVersion, display_name: String) {
        self.custard_version = custard_version
        self.display_name = display_name
    }

    ///version
    public var custard_version: CustardVersion

    ///display name
    /// - used in tab bar
    public var display_name: String
}

public struct Custard: Codable, Equatable {
    public init(identifier: String, language: CustardLanguage, input_style: CustardInputStyle, metadata: CustardMetadata, logics: CustardLogics = CustardLogics(initialValues: []), interface: CustardInterface) {
        self.identifier = identifier
        self.language = language
        self.input_style = input_style
        self.metadata = metadata
        self.logics = logics
        self.interface = interface
    }

    ///identifier
    /// - must be unique
    public var identifier: String

    ///language to convert
    public var language: CustardLanguage

    ///input style
    public var input_style: CustardInputStyle

    ///metadata
    public var metadata: CustardMetadata

    ///interface
    public var interface: CustardInterface

    /// logics
    public var logics: CustardLogics

    public func write(to url: URL) throws {
        let encoded_data = try JSONEncoder().encode(self)
        try encoded_data.write(to: url)
    }
}

extension Custard {
    private enum CodingKeys: CodingKey {
        case identifier
        case language
        case input_style
        case metadata
        case interface
        case logics
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.identifier = try container.decode(String.self, forKey: .identifier)
        self.language = try container.decode(CustardLanguage.self, forKey: .language)
        self.input_style = try container.decode(CustardInputStyle.self, forKey: .input_style)
        self.metadata = try container.decode(CustardMetadata.self, forKey: .metadata)
        self.interface = try container.decode(CustardInterface.self, forKey: .interface)
        if container.contains(.logics) {
            self.logics = try container.decode(CustardLogics.self, forKey: .logics)
        } else {
            self.logics = CustardLogics(initialValues: [])
        }
    }
}

extension Array where Element == Custard {
    public func write(to url: URL) throws {
        let encoded_data = try JSONEncoder().encode(self)
        try encoded_data.write(to: url)
    }
}

public struct CustardStateValue: Codable, Equatable {
    public enum Value: Codable, Equatable {
        case string(String)
        case bool(Bool)
    }

    public init(name: String, value: Value) {
        self.name = name
        self.value = value
    }

    public var value: Value
    public var name: String
}

public extension CustardStateValue {
    private enum CodingKeys: CodingKey {
        case name
        case type
        case value
    }
    private enum ValueType: String, Codable {
        case string
        case bool
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.name, forKey: .name)
        switch self.value {
        case let .bool(value):
            try container.encode(ValueType.bool, forKey: .type)
            try container.encode(value, forKey: .value)
        case let .string(value):
            try container.encode(ValueType.string, forKey: .type)
            try container.encode(value, forKey: .value)
        }
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let type = try container.decode(ValueType.self, forKey: .type)
        let name = try container.decode(String.self, forKey: .name)
        switch type {
        case .bool:
            let value = try container.decode(Bool.self, forKey: .value)
            self = CustardStateValue(name: name, value: .bool(value))
        case .string:
            let value = try container.decode(String.self, forKey: .value)
            self = CustardStateValue(name: name, value: .string(value))
        }
    }
}

public struct CustardLogics: Codable, Equatable {
    public init(initialValues: [CustardStateValue]) {
        self.initial_values = initialValues
    }
    public var initial_values: [CustardStateValue]
}


/// - インターフェースのキーのスタイルです
/// - style of keys
public enum CustardInterfaceStyle: String, Codable {
    /// - フリック可能なキー
    /// - flickable keys
    case tenkeyStyle = "tenkey_style"

    /// - 長押しで他の文字を選べるキー
    /// - keys with variations
    case pcStyle = "pc_style"
}

/// - インターフェースのレイアウトのスタイルです
/// - style of layout
public enum CustardInterfaceLayout: Codable, Equatable {
    /// - 画面いっぱいにマス目状で均等に配置されます
    /// - keys are evenly layouted in a grid pattern fitting to the screen
    case gridFit(CustardInterfaceLayoutGridValue)

    /// - はみ出した分はスクロールできる形でマス目状に均等に配置されます
    /// - keys are layouted in a scrollable grid pattern and can be overflown
    case gridScroll(CustardInterfaceLayoutScrollValue)
}

public extension CustardInterfaceLayout{
    private enum CodingKeys: CodingKey {
        case type
        case row_count, column_count
        case direction
    }
    private enum ValueType: String, Codable{
        case grid_fit
        case grid_scroll
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        switch self {
        case let .gridFit(value):
            try container.encode(ValueType.grid_fit, forKey: .type)
            try container.encode(value.rowCount, forKey: .row_count)
            try container.encode(value.columnCount, forKey: .column_count)
        case let .gridScroll(value):
            try container.encode(ValueType.grid_scroll, forKey: .type)
            try container.encode(value.direction, forKey: .direction)
            try container.encode(value.rowCount, forKey: .row_count)
            try container.encode(value.columnCount, forKey: .column_count)
        }
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let type = try container.decode(ValueType.self, forKey: .type)
        let rowCount = try container.decode(Double.self, forKey: .row_count)
        let columnCount = try container.decode(Double.self, forKey: .column_count)
        switch type {
        case .grid_fit:
            self = .gridFit(.init(rowCount: Int(rowCount), columnCount: Int(columnCount)))
        case .grid_scroll:
            let direction = try container.decode(CustardInterfaceLayoutScrollValue.ScrollDirection.self, forKey: .direction)
            self = .gridScroll(.init(direction: direction, rowCount: rowCount, columnCount: columnCount))
        }
    }
}

public struct CustardInterfaceLayoutGridValue: Equatable {
    public init(rowCount: Int, columnCount: Int) {
        self.rowCount = rowCount
        self.columnCount = columnCount
    }

    /// - 横方向に配置するキーの数
    /// - number of keys placed horizontally
    public var rowCount: Int
    /// - 縦方向に配置するキーの数
    /// - number of keys placed vertically
    public var columnCount: Int
}

public struct CustardInterfaceLayoutScrollValue: Equatable {
    public init(direction: ScrollDirection, rowCount: Double, columnCount: Double) {
        self.direction = direction
        self.rowCount = rowCount
        self.columnCount = columnCount
    }

    /// - スクロールの方向
    /// - direction of scroll
    public var direction: ScrollDirection

    /// - 一列に配置するキーの数
    /// - number of keys in scroll normal direction
    public var rowCount: Double

    /// - 画面内に収まるスクロール方向のキーの数
    /// - number of keys in screen in scroll direction
    public var columnCount: Double

    /// - direction of scroll
    public enum ScrollDirection: String, Codable{
        case vertical
        case horizontal
    }
}

/// - 画面内でのキーの位置を決める指定子
/// - the specifier of key's position in screen
public enum CustardKeyPositionSpecifier: Hashable {
    /// - gridFitのレイアウトを利用した際のキーの位置指定子
    /// - position specifier when you use grid fit layout
    case gridFit(GridFitPositionSpecifier)

    /// - gridScrollのレイアウトを利用した際のキーの位置指定子
    /// - position specifier when you use grid scroll layout
    case gridScroll(GridScrollPositionSpecifier)
}

/// - gridFitのレイアウトを利用した際のキーの位置指定子に与える値
/// - values in position specifier when you use grid fit layout
public struct GridFitPositionSpecifier: Codable, Hashable {
    public init(x: Int, y: Int, width: Int = 1, height: Int = 1) {
        self.x = x
        self.y = y
        self.width = width
        self.height = height
    }

    /// - 横方向の位置(左をゼロとする)
    /// - horizontal position (leading edge is zero)
    public var x: Int

    /// - 縦方向の位置(上をゼロとする)
    /// - vertical positon (top edge is zero)
    public var y: Int

    public var width: Int
    public var height: Int

    private enum CodingKeys: CodingKey{
        case x, y, width, height
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.x = try container.decode(Int.self, forKey: .x)
        self.y = try container.decode(Int.self, forKey: .y)
        let width = try container.decode(Int.self, forKey: .width)
        let height = try container.decode(Int.self, forKey: .height)
        (self.width, self.height) = (abs(width), abs(height))
    }
}

/// - gridScrollのレイアウトを利用した際のキーの位置指定子に与える値
/// - values in position specifier when you use grid scroll layout
public struct GridScrollPositionSpecifier: Codable, Hashable, ExpressibleByIntegerLiteral {
    /// - 通し番号
    /// - index
    public var index: Int

    public init(_ index: Int){
        self.index = index
    }
}

/// - 記述の簡便化のため定義
/// - conforms to protocol for writability
public extension GridScrollPositionSpecifier {
    typealias IntegerLiteralType = Int

    init(integerLiteral value: Int) {
        self.index = value
    }
}

/// - インターフェース
/// - interface
public struct CustardInterface: Codable, Equatable {
    public init(keyStyle: CustardInterfaceStyle, keyLayout: CustardInterfaceLayout, keys: [CustardKeyPositionSpecifier : CustardInterfaceKey]) {
        self.keyStyle = keyStyle
        self.keyLayout = keyLayout
        self.keys = keys
    }

    /// - キーのスタイル
    /// - style of keys
    /// - warning: Currently when you use gird scroll. layout, key style would be ignored.
    public var keyStyle: CustardInterfaceStyle

    /// - キーのレイアウト
    /// - layout of keys
    public var keyLayout: CustardInterfaceLayout

    /// - キーの辞書
    /// - dictionary of keys
    /// - warning: You must use specifiers consistent with key layout. When you use inconsistent one, it would be ignored.
    public var keys: [CustardKeyPositionSpecifier: CustardInterfaceKey]
}

public extension CustardInterface {
    private enum CodingKeys: CodingKey{
        case key_style
        case key_layout
        case keys
    }

    private enum KeyType: String, Codable {
        case custom, system
    }

    private enum SpecifierType: String, Codable {
        case grid_fit, grid_scroll
    }

    private struct Element: Codable{
        init(specifier: CustardKeyPositionSpecifier, key: CustardInterfaceKey) {
            self.specifier = specifier
            self.key = key
        }

        let specifier: CustardKeyPositionSpecifier
        let key: CustardInterfaceKey

        private var specifierType: SpecifierType {
            switch self.specifier{
            case .gridFit: return .grid_fit
            case .gridScroll: return .grid_scroll
            }
        }

        private var keyType: KeyType {
            switch self.key{
            case .system: return .system
            case .custom: return .custom
            }
        }

        private enum CodingKeys: CodingKey {
            case specifier_type
            case specifier
            case key_type
            case key
        }

        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(specifierType, forKey: .specifier_type)
            switch self.specifier{
            case let .gridFit(value as Encodable),
                 let .gridScroll(value as Encodable):
                try value.containerEncode(container: &container, key: CodingKeys.specifier)
            }
            try container.encode(keyType, forKey: .key_type)
            switch self.key{
            case let .system(value as Encodable),
                 let .custom(value as Encodable):
                try value.containerEncode(container: &container, key: CodingKeys.key)
            }
        }

        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            let specifierType = try container.decode(SpecifierType.self, forKey: .specifier_type)
            switch specifierType{
            case .grid_fit:
                let specifier = try container.decode(GridFitPositionSpecifier.self, forKey: .specifier)
                self.specifier = .gridFit(specifier)
            case .grid_scroll:
                let specifier = try container.decode(GridScrollPositionSpecifier.self, forKey: .specifier)
                self.specifier = .gridScroll(specifier)
            }

            let keyType = try container.decode(KeyType.self, forKey: .key_type)
            switch keyType{
            case .system:
                let key = try container.decode(CustardInterfaceSystemKey.self, forKey: .key)
                self.key = .system(key)
            case .custom:
                let key = try container.decode(CustardInterfaceCustomKey.self, forKey: .key)
                self.key = .custom(key)
            }
        }
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(keyStyle, forKey: .key_style)
        try container.encode(keyLayout, forKey: .key_layout)
        let elements = self.keys.map{Element(specifier: $0.key, key: $0.value)}
        try container.encode(elements, forKey: .keys)
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.keyStyle = try container.decode(CustardInterfaceStyle.self, forKey: .key_style)
        self.keyLayout = try container.decode(CustardInterfaceLayout.self, forKey: .key_layout)
        let elements = try container.decode([Element].self, forKey: .keys)
        self.keys = elements.reduce(into: [:]){dictionary, element in
            dictionary[element.specifier] = element.key
        }
    }
}

/// - キーのデザイン
/// - design information of key
public struct CustardKeyDesign: Codable, Equatable, Hashable {
    public init(label: CustardKeyLabelStyle, color: CustardKeyDesign.ColorType) {
        self.label = label
        self.color = color
    }

    public var label: CustardKeyLabelStyle
    public var color: ColorType

    public enum ColorType: String, Codable {
        case normal
        case special
        case selected
        case unimportant
    }
}

/// - バリエーションのキーのデザイン
/// - design information of key
public struct CustardVariationKeyDesign: Codable, Equatable, Hashable {
    public init(label: CustardKeyLabelStyle) {
        self.label = label
    }

    public var label: CustardKeyLabelStyle
}

/// - キーに指定するラベル
/// - labels on the key
public enum CustardKeyLabelStyle: Codable, Equatable, Hashable {
    case text(String)
    case systemImage(String)
}

public extension CustardKeyLabelStyle {
    private enum CodingKeys: CodingKey {
        case text
        case system_image
    }

    private var key: CodingKeys {
        switch self{
        case .text: return .text
        case .systemImage: return .system_image
        }
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        switch self {
        case let .text(value),
             let .systemImage(value):
            try container.encode(value, forKey: key)
        }
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        guard let key = container.allKeys.first else{
            throw DecodingError.dataCorrupted(
                DecodingError.Context(
                    codingPath: container.codingPath,
                    debugDescription: "Unabled to decode CustardKeyLabelStyle."
                )
            )
        }
        switch key {
        case .text:
            let value = try container.decode(
                String.self,
                forKey: .text
            )
            self = .text(value)
        case .system_image:
            let value = try container.decode(
                String.self,
                forKey: .system_image
            )
            self = .systemImage(value)
        }
    }
}

/// - key's data in interface
public enum CustardInterfaceKey: Equatable, Hashable {
    case system(CustardInterfaceSystemKey)
    case custom(CustardInterfaceCustomKey)
}

/// - keys prepared in default
public enum CustardInterfaceSystemKey: Codable, Equatable, Hashable {
    /// - the globe key
    case changeKeyboard

    /// - the enter key that changes its label in condition
    case enter

    ///custom keys.
    /// - flick 小ﾞﾟkey
    case flickKogaki
    /// - flick ､｡!? key
    case flickKutoten
    /// - flick hiragana tab
    case flickHiraTab
    /// - flick abc tab
    case flickAbcTab
    /// - flick number and symbols tab
    case flickStar123Tab
}

public extension CustardInterfaceSystemKey{
    private enum CodingKeys: CodingKey {
        case type
    }

    private enum ValueType: String, Codable {
        case change_keyboard
        case enter
        case flick_kogaki
        case flick_kutoten
        case flick_hira_tab
        case flick_abc_tab
        case flick_star123_tab
    }

    private var valueType: ValueType {
        switch self{
        case .changeKeyboard: return .change_keyboard
        case .enter: return .enter
        case .flickKogaki: return .flick_kogaki
        case .flickKutoten: return .flick_kutoten
        case .flickHiraTab: return .flick_hira_tab
        case .flickAbcTab: return .flick_abc_tab
        case .flickStar123Tab: return .flick_star123_tab
        }
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.valueType, forKey: .type)
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let type = try container.decode(ValueType.self, forKey: .type)
        switch type {
        case .enter:
            self = .enter
        case .change_keyboard:
            self = .changeKeyboard
        case .flick_kogaki:
            self = .flickKogaki
        case .flick_kutoten:
            self = .flickKutoten
        case .flick_hira_tab:
            self = .flickHiraTab
        case .flick_abc_tab:
            self = .flickAbcTab
        case .flick_star123_tab:
            self = .flickStar123Tab
        }
    }
}

/// - keys you can defined
public struct CustardInterfaceCustomKey: Codable, Equatable, Hashable {
    public init(design: CustardKeyDesign, press_actions: [CodableActionData], longpress_actions: CodableLongpressActionData, variations: [CustardInterfaceVariation]) {
        self.design = design
        self.press_actions = press_actions
        self.longpress_actions = longpress_actions
        self.variations = variations
    }

    /// - design of this key
    public var design: CustardKeyDesign

    /// - actions done when this key is pressed. actions are done in order.
    public var press_actions: [CodableActionData]

    /// - actions done when this key is longpressed. actions are done in order.
    public var longpress_actions: CodableLongpressActionData

    /// - variations available when user flick or longpress this key
    public var variations: [CustardInterfaceVariation]
}


public extension CustardInterfaceCustomKey {
    /// Create simple input key using flick
    /// - parameters:
    ///  - center: string inputed when tap the key
    ///  - subs: set string inputed when flick the key up to four letters. letters are stucked in order left -> top -> right -> bottom
    ///  - centerLabel: (optional) if needed, set label of center. without specification `center` is set as label
    static func flickSimpleInputs(center: String, subs: [String], centerLabel: String? = nil) -> Self {
        let variations: [CustardInterfaceVariation] = zip(subs, [FlickDirection.left, .top, .right, .bottom]).map{letter, direction in
            .init(
                type: .flickVariation(direction),
                key: .init(
                    design: .init(label: .text(letter)),
                    press_actions: [.input(letter)],
                    longpress_actions: .none
                )
            )
        }

        return .init(
            design: .init(label: .text(centerLabel ?? center), color: .normal),
            press_actions: [.input(center)],
            longpress_actions: .none,
            variations: variations
        )
    }

    /// Create simple input key using flick
    /// - parameters:
    ///  - center: if label and input are the same value, simply set the literal or explicitly `.init(string)`. otherwise use `.init(input: String, label: String)`.
    ///  - left: optional. if label and input are the same value, simply set the literal or explicitly `.init(string)`. otherwise use `.init(input: String, label: String)`.
    ///  - top: optional. if label and input are the same value, simply set the literal or explicitly `.init(string)`. otherwise use `.init(input: String, label: String)`.
    ///  - right: optional. if label and input are the same value, simply set the literal or explicitly `.init(string)`. otherwise use `.init(input: String, label: String)`.
    ///  - bottom: optional. if label and input are the same value, simply set the literal or explicitly `.init(string)`. otherwise use `.init(input: String, label: String)`.
    static func flickSimpleInputs(center: SimpleInputArgument, left: SimpleInputArgument? = nil, top: SimpleInputArgument? = nil, right: SimpleInputArgument? = nil, bottom: SimpleInputArgument? = nil) -> Self {
        let variations: [CustardInterfaceVariation] = zip([left, top, right, bottom], [FlickDirection.left, .top, .right, .bottom]).compactMap{argument, direction in
            if let argument = argument {
               return .init(
                    type: .flickVariation(direction),
                    key: .init(
                        design: .init(label: .text(argument.label)),
                        press_actions: [.input(argument.input)],
                        longpress_actions: .none
                    )
                )
            }
            return nil
        }

        return .init(
            design: .init(label: .text(center.label), color: .normal),
            press_actions: [.input(center.input)],
            longpress_actions: .none,
            variations: variations
        )
    }

    struct SimpleInputArgument: Equatable, ExpressibleByStringLiteral {
        let label: String
        let input: String

        public typealias StringLiteralType = String

        public init(label: String, input: String) {
            self.label = label
            self.input = input
        }
        public init(stringLiteral: String){
            self.init(stringLiteral)
        }
        public init(_ input: String){
            self.label = input
            self.input = input
        }
    }

    static func flickDelete() -> Self {
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
            ]
        )
    }

    static func flickSpace() -> Self {
        .init(
            design: .init(label: .text("空白"), color: .special),
            press_actions: [.input(" ")],
            longpress_actions: .init(start: [.setCursorBar(.toggle)]),
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
                        design: .init(label: .text("全角")),
                        press_actions: [.input("　")],
                        longpress_actions: .none
                    )
                ),
                .init(
                    type: .flickVariation(.bottom),
                    key: .init(
                        design: .init(label: .text("tab")),
                        press_actions: [.input("\t")],
                        longpress_actions: .none
                    )
                )
            ]
        )
    }
}

/// - variation of key, includes flick keys and selectable variations in pc style keyboard.
public struct CustardInterfaceVariation: Codable, Equatable, Hashable {
    public init(type: VariationType, key: CustardInterfaceVariationKey) {
        self.type = type
        self.key = key
    }

    /// - type of the variation
    public var type: VariationType

    /// - data of variation
    public var key: CustardInterfaceVariationKey

    /// - キーの変種の種類
    /// - type of key variation
    public enum VariationType: Equatable, Hashable {
        /// - variation of flick
        /// - warning: when you use pc style, this type of variation would be ignored.
        case flickVariation(FlickDirection)

        /// - variation selectable when keys were longoressed, especially used in pc style keyboard.
        /// - warning: when you use flick key style, this type of variation would be ignored.
        case longpressVariation
    }
}

public extension CustardInterfaceVariation {
    private enum CodingKeys: CodingKey{
        case type
        case direction
        case key
    }

    private enum ValueType: String, Codable {
        case flick_variation
        case longpress_variation
    }

    private var valueType: ValueType {
        switch self.type{
        case .flickVariation: return .flick_variation
        case .longpressVariation: return .longpress_variation
        }
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.key, forKey: .key)
        try container.encode(self.valueType, forKey: .type)
        switch self.type{
        case let .flickVariation(value):
            try container.encode(value, forKey: .direction)
        case .longpressVariation:
            break
        }
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.key = try container.decode(CustardInterfaceVariationKey.self, forKey: .key)
        let valueType = try container.decode(ValueType.self, forKey: .type)
        switch valueType{
        case .flick_variation:
            let direction = try container.decode(FlickDirection.self, forKey: .direction)
            self.type = .flickVariation(direction)
        case .longpress_variation:
            self.type = .longpressVariation
        }
    }
}

/// - data of variation key
public struct CustardInterfaceVariationKey: Codable, Equatable, Hashable {
    public init(design: CustardVariationKeyDesign, press_actions: [CodableActionData], longpress_actions: CodableLongpressActionData) {
        self.design = design
        self.press_actions = press_actions
        self.longpress_actions = longpress_actions
    }

    /// - label on this variation
    public var design: CustardVariationKeyDesign

    /// - actions done when you select this variation. actions are done in order..
    public var press_actions: [CodableActionData]

    /// - actions done when you 'long select' this variation, like long-flick. actions are done in order.
    public var longpress_actions: CodableLongpressActionData
}

/// - Tab specifier
public enum TabData: Hashable{
    /// - tabs prepared by default
    case system(SystemTab)
    /// - tabs made as custom tabs.
    case custom(String)

    /// - system tabs
    public enum SystemTab: String, Codable, Hashable{
        ///japanese input tab. the layout and input style depends on user's setting
        case user_japanese

        ///english input tab. the layout and input style depends on user's setting
        case user_english

        ///flick japanese input tab
        case flick_japanese

        ///flick enlgish input tab
        case flick_english

        ///flick number and symbols input tab
        case flick_numbersymbols

        ///qwerty japanese input tab
        case qwerty_japanese

        ///qwerty english input tab
        case qwerty_english

        ///qwerty number input tab
        case qwerty_numbers

        ///qwerty symbols input tab
        case qwerty_symbols

        ///the last tab
        case last_tab
    }
}

public struct ScanItem: Hashable {
    public init(targets: [String], direction: ScanItem.Direction) {
        self.targets = targets
        self.direction = direction
    }

    public var targets: [String]
    public var direction: Direction

    public enum Direction: String, Codable {
        case forward
        case backward
    }
}

public struct LaunchItem: Hashable {
    public init(scheme: LaunchableApplication, target: String) {
        self.scheme = scheme
        self.target = target
    }

    public var scheme: LaunchableApplication
    public var target: String

    public enum LaunchableApplication: String, Codable {
        case azooKey
        case shortcuts
    }
}

public enum BoolOperation: String, Codable, Hashable {
    case on
    case off
    case toggle
}

/// - アクション
/// - actions done in key pressing
public indirect enum CodableActionData: Codable, Hashable {
    /// - input action specified character
    case input(String)

    /// - exchange character "あ→ぁ", "は→ば", "a→A"
    case replaceDefault

    /// - replace string at the trailing of cursor following to specified table
    case replaceLastCharacters([String: String])

    /// - delete action specified count of characters
    case delete(Int)

    /// - delete to beginning of the sentence
    case smartDeleteDefault

    /// - delete to the ` direction` until `target` appears in the direction of travel..
    /// - if `target` is `[".", ","]`, `direction` is `.backward`, and current text is `I love this. But |she likes`, after the action, the text become `I love this.|she likes`.
    case smartDelete(ScanItem = .init(targets: Self.scanTargets, direction: .forward))

    /// - complete current inputting words
    case complete

    /// - move cursor  specified count forward. when you specify negative number, the cursor moves backword
    case moveCursor(Int)

    /// - move cursor to the ` direction` until `target` appears in the direction of travel..
    /// - if `target` is `[".", ","]`, `direction` is `.backward`, and current text is `I love this. But |she likes`, after the action, the text become `I love this.| But she likes`.
    case smartMoveCursor(ScanItem = .init(targets: Self.scanTargets, direction: .forward))

    /// - move to specified tab
    case moveTab(TabData)

    /// - enable keyboard resizing mode
    case enableResizingMode

    /// - set on / off / toggle for cursor move bar
    case setCursorBar(BoolOperation)

    /// - toggle show or not show the cursor move bar
    @available(*, deprecated, message: "This action is deprecated. Use .setCursorBar(.toggle) instead.")
    case toggleCursorBar

    /// - set on / off / toggle for capslock state
    case setCapsLockState(BoolOperation)

    /// - toggle capslock or not
    @available(*, deprecated, message: "This action is deprecated. Use .setCapsLockState(.toggle) instead.")
    case toggleCapsLockState

    /// - set on / off / toggle for tab bar
    case setTabBar(BoolOperation)

    /// - toggle show or not show the tab bar
    @available(*, deprecated, message: "This action is deprecated. Use .setTabBar(.toggle) instead.")
    case toggleTabBar

    /// - dismiss keyboard
    case dismissKeyboard

    /// - launch apps
    case launchApplication(LaunchItem)

    /// - set boolean value for state
    ///  - state: name of state
    ///  - value: bool expression like "not((state_a == 'normal') and state_b)"
    // TODO: add documents for this action
    case setBoolState(state: String, value: String)

    /// - conditional operation based on boolean value
    ///  - String: bool expression like "not((state_a == 'normal') and state_b)"
    ///  - trueActions: actions
    // TODO: add documents for this action
    case boolSwitch(condition: String, trueActions: [CodableActionData], falseActions: [CodableActionData])

    public static let scanTargets = ["、","。","！","？",".",",","．","，", "\n"]
}

public extension CodableActionData{
    private enum CodingKeys: CodingKey {
        case type
        case text
        case count
        case table
        case tab_type, identifier
        case direction, targets
        case scheme_type, target
        case operation
        case state_name
        case bool_expression
        case true_actions, false_actions
    }

    private enum ValueType: String, Codable{
        case input
        case replace_default
        case replace_last_characters
        case delete
        case smart_delete
        case smart_delete_default
        case complete
        case move_cursor
        case smart_move_cursor
        case move_tab
        case enable_resizing_mode
        case set_cursor_bar
        case toggle_cursor_bar
        case set_tab_bar
        case toggle_tab_bar
        case set_caps_lock_state
        case toggle_caps_lock_state
        case dismiss_keyboard
        case launch_application
        case set_bool_state
        case bool_switch
    }

    private var key: ValueType {
        switch self {
        case .complete: return .complete
        case .delete: return .delete
        case .dismissKeyboard: return .dismiss_keyboard
        case .input: return .input
        case .launchApplication: return .launch_application
        case .moveCursor: return .move_cursor
        case .moveTab: return .move_tab
        case .replaceDefault: return .replace_default
        case .replaceLastCharacters: return .replace_last_characters
        case .setCapsLockState: return .set_caps_lock_state
        case .setCursorBar: return .set_cursor_bar
        case .setTabBar: return .set_tab_bar
        case .smartDelete: return .smart_delete
        case .smartDeleteDefault: return .smart_delete_default
        case .smartMoveCursor: return .smart_move_cursor
        case .enableResizingMode: return .enable_resizing_mode
        // These actions are silently encoded to recommended action.
        case .toggleCapsLockState: return .set_caps_lock_state
        case .toggleCursorBar: return .set_cursor_bar
        case .toggleTabBar: return .set_tab_bar
        case .setBoolState: return .set_bool_state
        case .boolSwitch: return .bool_switch
        }
    }

    private struct CodableTabArgument{
        internal init(tab: TabData) {
            self.tab = tab
        }
        private var tab: TabData

        private enum TabType: String, Codable{
            case custom, system
        }

        func containerEncode(container: inout KeyedEncodingContainer<CodingKeys>) throws {
            switch tab{
            case .system:
                try container.encode(TabType.system, forKey: .tab_type)
            case .custom:
                try container.encode(TabType.custom, forKey: .tab_type)
            }
            switch tab {
            case let .system(value as Encodable),
                 let .custom(value as Encodable):
                try value.containerEncode(container: &container, key: .identifier)
            }
        }

        static func containerDecode(container: KeyedDecodingContainer<CodingKeys>) throws -> TabData {
            let type = try container.decode(TabType.self, forKey: .tab_type)
            switch type {
            case .system:
                let tab = try container.decode(TabData.SystemTab.self, forKey: .identifier)
                return .system(tab)
            case .custom:
                let tab = try container.decode(String.self, forKey: .identifier)
                return .custom(tab)
            }
        }
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.key, forKey: .type)
        switch self {
        case let .input(value):
            try container.encode(value, forKey: .text)
        case let .replaceLastCharacters(value):
            try container.encode(value, forKey: .table)
        case let .delete(value), let .moveCursor(value):
            try container.encode(value, forKey: .count)
        case let .smartDelete(value), let .smartMoveCursor(value):
            try container.encode(value.direction, forKey: .direction)
            try container.encode(value.targets, forKey: .targets)
        case let .launchApplication(value):
            try container.encode(value.scheme, forKey: .scheme_type)
            try container.encode(value.target, forKey: .target)
        case let .setCapsLockState(value), let .setCursorBar(value), let .setTabBar(value):
            try container.encode(value, forKey: .operation)
        case let .moveTab(value):
            try CodableTabArgument(tab: value).containerEncode(container: &container)
        case let .setBoolState(stateName, expression):
            try container.encode(stateName, forKey: .state_name)
            try container.encode(expression, forKey: .bool_expression)
        case let .boolSwitch(expression, trueActions, falseActions):
            try container.encode(expression, forKey: .bool_expression)
            try container.encode(trueActions, forKey: .true_actions)
            try container.encode(falseActions, forKey: .false_actions)
        case .toggleTabBar, .toggleCursorBar, .toggleCapsLockState:
            try container.encode(BoolOperation.toggle, forKey: .operation)
        case .dismissKeyboard, .enableResizingMode, .complete, .smartDeleteDefault, .replaceDefault: break
        }
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let valueType = try container.decode(ValueType.self, forKey: .type)
        switch valueType {
        case .input:
            let value = try container.decode(String.self, forKey: .text)
            self = .input(value)
        case .replace_default:
            self = .replaceDefault
        case .replace_last_characters:
            let value = try container.decode([String: String].self, forKey: .table)
            self = .replaceLastCharacters(value)
        case .delete:
            let value = try container.decode(Int.self, forKey: .count)
            self = .delete(value)
        case .smart_delete_default:
            self = .smartDeleteDefault
        case .smart_delete:
            let direction = try container.decode(ScanItem.Direction.self, forKey: .direction)
            let targets = try container.decode([String].self, forKey: .targets)
            self = .smartDelete(.init(targets: targets, direction: direction))
        case .complete:
            self = .complete
        case .move_cursor:
            let value = try container.decode(Int.self, forKey: .count)
            self = .moveCursor(value)
        case .smart_move_cursor:
            let direction = try container.decode(ScanItem.Direction.self, forKey: .direction)
            let targets = try container.decode([String].self, forKey: .targets)
            self = .smartMoveCursor(.init(targets: targets, direction: direction))
        case .move_tab:
            let value = try CodableTabArgument.containerDecode(container: container)
            self = .moveTab(value)
        case .enable_resizing_mode:
            self = .enableResizingMode
        case .set_cursor_bar:
            let operation = try container.decode(BoolOperation.self, forKey: .operation)
            self = .setCursorBar(operation)
        case .toggle_cursor_bar:
            self = .setCursorBar(.toggle)
        case .set_caps_lock_state:
            let operation = try container.decode(BoolOperation.self, forKey: .operation)
            self = .setCapsLockState(operation)
        case .toggle_caps_lock_state:
            self = .setCapsLockState(.toggle)
        case .set_tab_bar:
            let operation = try container.decode(BoolOperation.self, forKey: .operation)
            self = .setTabBar(operation)
        case .toggle_tab_bar:
            self = .setTabBar(.toggle)
        case .dismiss_keyboard:
            self = .dismissKeyboard
        case .launch_application:
            let scheme = try container.decode(LaunchItem.LaunchableApplication.self, forKey: .scheme_type)
            let target = try container.decode(String.self, forKey: .target)
            self = .launchApplication(.init(scheme: scheme, target: target))
        case .set_bool_state:
            let state = try container.decode(String.self, forKey: .state_name)
            let expression = try container.decode(String.self, forKey: .bool_expression)
            self = .setBoolState(state: state, value: expression)
        case .bool_switch:
            let expression = try container.decode(String.self, forKey: .bool_expression)
            let trueActions = try container.decode([CodableActionData].self, forKey: .true_actions)
            let falseActions = try container.decode([CodableActionData].self, forKey: .false_actions)
            self = .boolSwitch(condition: expression, trueActions: trueActions, falseActions: falseActions)
        }
    }
}


public struct CodableLongpressActionData: Codable, Equatable, Hashable {
    public static let none = CodableLongpressActionData()
    public init(start: [CodableActionData] = [], repeat: [CodableActionData] = []) {
        self.start = start
        self.repeat = `repeat`
    }

    public var start: [CodableActionData]
    public var `repeat`: [CodableActionData]
}
