from source.custard import *

custard = Custard(
    custard_version = "1.0",
    identifier = "my_custard", 
    display_name = "私のカスタード",
    language = Language.ja_JP, 
    input_style = InputStyle.direct,
    interface = Interface(
        key_style = KeyStyle.tenkey_style,
        key_layout = GridFitLayout(row_count = 2, column_count = 2),
        keys = [
            KeyData(
                specifier = Specifier(type = SpecifierType.grid_fit, value = {"x": 0, "y": 0}),
                key = SystemKey(SystemKeyType.change_keyboard)
            ),
            KeyData(
                specifier = Specifier(type = SpecifierType.grid_fit, value = {"x": 0, "y": 1}),
                key = CustomKey(
                    design = KeyDesign(
                        label = TextLabel(text = "あ"),
                        color = KeyColor.normal
                    ),
                    press_actions = [],
                    longpress_actions = LongpressAction(
                        start = [
                            action_delete(1),
                        ]
                    ),
                    variations = [
                        FlickVariationData(
                            direction = FlickDirection.left,
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
                specifier = Specifier(type = SpecifierType.grid_fit, value = {"x": 1, "y": 0}),
                key = CustomKey(
                    design = KeyDesign(
                        label = TextLabel(text = "あ"),
                        color = KeyColor.normal
                    ),
                    press_actions = [],
                    longpress_actions = LongpressAction(
                        start = [
                            action_delete(1),
                        ]
                    ),
                    variations = [
                        FlickVariationData(
                            direction = FlickDirection.left,
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
                specifier = Specifier(type = SpecifierType.grid_fit, value = {"x": 1, "y": 1}),
                key = CustomKey(
                    design = KeyDesign(
                        label = TextLabel(text = "あ"),
                        color = KeyColor.normal
                    ),
                    press_actions = [],
                    longpress_actions = LongpressAction(
                        start = [
                            action_delete(1),
                        ]
                    ),
                    variations = [
                        FlickVariationData(
                            direction = FlickDirection.left,
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