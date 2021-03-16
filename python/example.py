from source.custard import *

custard = Custard(
    identifier = "my_custard", 
    display_name = "私のカスタード",
    language = "ja_JP", 
    input_style = "direct",
    interface = Interface(
        key_style = "tenkey_style",
        key_layout = GridFitLayout(row_count = 2, column_count = 2),
        keys = [
            KeyData(
                specifier = Specifier(type = "grid_fit", value = {"x": 0, "y": 0}),
                key = SystemKey(identifier = "change_keyboard")
            ),
            KeyData(
                specifier = Specifier(type = "grid_fit", value = {"x": 0, "y": 1}),
                key = CustomKey(
                    design = KeyDesign(
                        label = TextLabel(text = "あ"),
                        color = "normal"
                    ),
                    press_actions = [],
                    longpress_actions = LongpressAction(
                        start = [
                            action_delete(1),
                        ]
                    ),
                    variations = [
                        FlickVariationData(
                            direction = "left",
                            key = Variation(
                                design = VariationDesign(
                                    label = TextLabel(text = "い"),
                                ),
                                press_actions = [
                                    action_input("い")
                                ],
                                longpress_actions = LongpressAction()
                            )
                        )
                    ]
                )
            ),

           KeyData(
                specifier = Specifier(type = "grid_fit", value = {"x": 1, "y": 0}),
                key = CustomKey(
                    design = KeyDesign(
                        label = TextLabel(text = "あ"),
                        color = "normal"
                    ),
                    press_actions = [],
                    longpress_actions = LongpressAction(
                        start = [
                            action_delete(1),
                        ]
                    ),
                    variations = [
                        FlickVariationData(
                            direction = "left",
                            key = Variation(
                                design = VariationDesign(
                                    label = TextLabel(text = "い"),
                                ),
                                press_actions = [
                                    action_input("い")
                                ],
                            )
                        )
                    ]
                )
            ),

            KeyData(
                specifier = Specifier(type = "grid_fit", value = {"x": 1, "y": 1}),
                key = CustomKey(
                    design = KeyDesign(
                        label = TextLabel(text = "あ"),
                        color = "normal"
                    ),
                    press_actions = [],
                    longpress_actions = LongpressAction(
                        start = [
                            action_delete(1),
                        ]
                    ),
                    variations = [
                        FlickVariationData(
                            direction = "left",
                            key = Variation(
                                design = VariationDesign(
                                    label = TextLabel(text = "い"),
                                ),
                                press_actions = [
                                    action_input("い")
                                ],
                            )
                        )
                    ]
                )
            ),
        ]
    )
)

custard.write(to = "./results/my_custard.json")

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
