from source.custard import *
#ヒエログリフの文字のリストを取得
hieroglyphs = list(map(lambda x: chr(x), range(0x13000, 0x133FF+1)))

#キーの辞書を作成
hieroglyphs_keys = [
    KeyData(
        specifier = Specifier(type = "grid_scroll", value = {"index": 0}),
        key = SystemKey(identifier = "change_keyboard")
    ),
    KeyData(
        specifier = Specifier(type = "grid_scroll", value = {"index": 1}),
        key = CustomKey(
            design = KeyDesign(
                label = TextLabel(text = "←"),
                color = "special"
            ),
            press_actions = [
                action_move_cursor(-1)
            ],
            longpress_actions = LongpressAction(
                repeat = [
                    action_move_cursor(-1)
			    ]
            ),
            variations = []
        )
    ),
    KeyData(
        specifier = Specifier(type = "grid_scroll", value = {"index": 2}),
        key = CustomKey(
            design = KeyDesign(
                label = TextLabel(text = "→"),
                color = "special"
            ),
            press_actions = [
                action_move_cursor(1)
            ],
            longpress_actions = LongpressAction(
                repeat = [
                    action_move_cursor(1)
                ]
            ),
            variations = []
        )
    ),
    KeyData(
        specifier = Specifier(type = "grid_scroll", value = {"index": 3}),
        key = CustomKey(
            design = KeyDesign(
                label = SystemImageLabel(identifier = "list.bullet"),
                color = "special"
            ),
            press_actions = [
                action_toggle_tab_bar()
            ],
            longpress_actions = LongpressAction(),
            variations = []
        )
    ),
    KeyData(
        specifier = Specifier(type = "grid_scroll", value = {"index": 4}),
        key = CustomKey(
            design = KeyDesign(
                label = SystemImageLabel(identifier = "delete.left"),
                color = "special"
            ),
            press_actions = [
                action_delete(1)
            ],
            longpress_actions = LongpressAction(
                repeat = [
                    action_move_cursor(1)
                ]
            ),
          	variations = []
        )
    ),
]

for glyph in hieroglyphs:
    key = CustomKey(
        design = KeyDesign(
            label = TextLabel(text = glyph),
            color = "normal"
        ),
        press_actions = [
            action_input(glyph)
        ],
        longpress_actions = LongpressAction(),
        variations = []
    )
    keydata = KeyData(
        specifier = Specifier(type = "grid_scroll", value = {"index": len(hieroglyphs_keys)}),
        key = key
    )
    hieroglyphs_keys.append(keydata)
      
#カスタードオブジェクトを作成
hieroglyphs_custard = Custard(
    custard_version = "1.0",
    identifier = "Hieroglyphs",
    display_name = "ヒエログリフ",
    language = "none",
    input_style = "direct",
    interface = Interface(
        key_style = "tenkey_style",
        key_layout = GridScrollLayout(direction = "vertical", row_count = 8, column_count = 4.2),
        keys = hieroglyphs_keys
    )
)
hieroglyphs_custard.write(to = "./results/hieroglyphs.json")
