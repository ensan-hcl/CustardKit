from source.custard import *

def pc_style_input_key(char: str) -> CustomKey :
    return CustomKey(
        design = KeyDesign(
            label = TextLabel(text = char),
            color = KeyColor.normal
        ),
        press_actions = [
            action_input(char)
        ],
        longpress_actions = LongpressAction(),
        variations = []
    )

keys: list[KeyData] = []

numbers = [
    list("1234567890"),
    list("①②③④⑤⑥⑦⑧⑨⓪"),
    list("𝟙𝟚𝟛𝟜𝟝𝟞𝟟𝟠𝟡𝟘"),
    list("𝟏𝟐𝟑𝟒𝟓𝟔𝟕𝟖𝟗𝟎")
]

for i in range(len(numbers)):
    for j in range(len(numbers[i])):
        x, y = (j, i)
        keyData = KeyData(
            specifier = Specifier(type = SpecifierType.grid_fit, value = GridFitSpecifierValue(x = x, y = y)),
            key = pc_style_input_key(numbers[i][j])
        )
        keys.append(keyData)

keys.append(KeyData(
    specifier = Specifier(type = SpecifierType.grid_fit, value = GridFitSpecifierValue(x = 0, y = 4)),
    key = CustomKey(
        design = KeyDesign(
            label = SystemImageLabel("list.bullet"),
            color = KeyColor.special
        ),
        press_actions = [
            action_toggle_tab_bar()
        ],
        longpress_actions = LongpressAction(),
        variations = []
    )
))

keys.append(KeyData(
    specifier = Specifier(type = SpecifierType.grid_fit, value = GridFitSpecifierValue(x = 1, y = 4)),
    key = SystemKey(SystemKeyType.change_keyboard)
))

keys.append(KeyData(
    specifier = Specifier(type = SpecifierType.grid_fit, value = GridFitSpecifierValue(x = 2, y = 4)),
    key = CustomKey(
        design = KeyDesign(
            label = SystemImageLabel("delete.left"),
            color = KeyColor.special
        ),
        press_actions = [
            action_delete(1)
        ],
        longpress_actions = LongpressAction(
            repeat = [
                action_delete(1)
            ]
        ),
        variations = []
    )
))

keys.append(KeyData(
    specifier = Specifier(type = SpecifierType.grid_fit, value = GridFitSpecifierValue(x = 3, y = 4, width = 4, height = 1)),
    key = CustomKey(
        design = KeyDesign(
            label = TextLabel("空白"),
            color = KeyColor.normal
        ),
        press_actions = [
            action_input(" ")
        ],
        longpress_actions = LongpressAction(
            start = [
                action_toggle_cursor_bar()
            ]
        ),
        variations = []
    )
))

keys.append(KeyData(
    specifier = Specifier(type = SpecifierType.grid_fit, value = GridFitSpecifierValue(x = 7, y = 4, width = 3, height = 1)),
    key = SystemKey(SystemKeyType.enter)
))

#カスタードオブジェクトを作成
hieroglyphs_custard = Custard(
    identifier = "number_font",
    language = Language.none,
    input_style = InputStyle.direct,
    metadata = Metadata(
        custard_version = "1.0",
        display_name = "装飾数字",
    ),
    interface = Interface(
        key_style = KeyStyle.pc_style,
        key_layout = GridFitLayout(row_count = 10, column_count = 5),
        keys = keys
    )
)
hieroglyphs_custard.write(to = "./results/number_font.json")
