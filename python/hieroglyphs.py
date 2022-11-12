from source.custard import *

# ヒエログリフの文字のリストを取得
hieroglyphs = list(map(lambda x: chr(x), range(0x13000, 0x133FF+1)))

# キーのリストを作成
hieroglyphs_keys = [
    KeyData(
        specifier=GridScrollSpecifier(index=0),
        key=SystemKey(SystemKeyType.change_keyboard)
    ),
    KeyData(
        specifier=GridScrollSpecifier(index=1),
        key=CustomKey(
            design=KeyDesign(
                label=TextLabel(text="←"),
                color=KeyColor.special
            ),
            press_actions=[
                MoveCursorAction(-1)
            ],
            longpress_actions=LongpressAction(
                repeat=[
                    MoveCursorAction(-1)
                ]
            ),
            variations=[]
        )
    ),
    KeyData(
        specifier=GridScrollSpecifier(index=2),
        key=CustomKey(
            design=KeyDesign(
                label=TextLabel(text="→"),
                color=KeyColor.special
            ),
            press_actions=[
                MoveCursorAction(1)
            ],
            longpress_actions=LongpressAction(
                repeat=[
                    MoveCursorAction(1)
                ]
            ),
            variations=[]
        )
    ),
    KeyData(
        specifier=GridScrollSpecifier(index=3),
        key=CustomKey(
            design=KeyDesign(
                label=SystemImageLabel(identifier="list.bullet"),
                color=KeyColor.special
            ),
            press_actions=[
                SetTabBarAction(BoolOperation.toggle)
            ],
            longpress_actions=LongpressAction(),
            variations=[]
        )
    ),
    KeyData(
        specifier=GridScrollSpecifier(index=4),
        key=CustomKey(
            design=KeyDesign(
                label=SystemImageLabel(identifier="delete.left"),
                color=KeyColor.special
            ),
            press_actions=[
                DeleteAction(1)
            ],
            longpress_actions=LongpressAction(
                repeat=[
                    MoveCursorAction(1)
                ]
            ),
            variations=[]
        )
    ),
]

for glyph in hieroglyphs:
    key = CustomKey(
        design=KeyDesign(
            label=TextLabel(text=glyph),
            color=KeyColor.normal
        ),
        press_actions=[
            InputAction(glyph)
        ],
        longpress_actions=LongpressAction(),
        variations=[]
    )
    keydata = KeyData(
        specifier=GridScrollSpecifier(index=len(hieroglyphs_keys)),
        key=key
    )
    hieroglyphs_keys.append(keydata)

# カスタードオブジェクトを作成
hieroglyphs_custard = Custard(
    identifier="Hieroglyphs",
    language=Language.none,
    input_style=InputStyle.direct,
    metadata=Metadata(
        custard_version="1.0",
        display_name="ヒエログリフ",
    ),
    interface=Interface(
        key_style=KeyStyle.tenkey_style,
        key_layout=GridScrollLayout(
            direction=ScrollDirection.vertical, row_count=8, column_count=4.2),
        keys=hieroglyphs_keys
    )
)
hieroglyphs_custard.write(name="hieroglyphs")
