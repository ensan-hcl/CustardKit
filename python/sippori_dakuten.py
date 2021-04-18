from source.custard import *

key_あ = CustomKey.flickSimpleInputs(
    center="あ",
    subs=list("いうえお")
)
key_か = CustomKey.flickSimpleInputs(
    center="か",
    subs=list("きくけこ")
)
key_さ = CustomKey.flickSimpleInputs(
    center="さ",
    subs=list("しすせそ")
)
key_た = CustomKey.flickSimpleInputs(
    center="た",
    subs=list("ちつてと")
)
key_な = CustomKey.flickSimpleInputs(
    center="な",
    subs=list("にぬねの")
)
key_は = CustomKey.flickSimpleInputs(
    center="は",
    subs=list("ひふへほ")
)
key_ま = CustomKey.flickSimpleInputs(
    center="ま",
    subs=list("みむめも")
)
key_や = CustomKey.flickSimpleInputs(
    center="や",
    subs=list("「ゆ」よ")
)
key_ら = CustomKey.flickSimpleInputs(
    center="ら",
    subs=list("りるれろ")
)
key_わ = CustomKey.flickSimpleInputs(
    center="わ",
    subs=list("をんー")
)
hiragana_replaceAction = ReplaceLastCharactersAction({
    #あ行
    #あ→ぁ→あ゛→ぁ゛→あ
    "あ": "ぁ",
    "ぁ": chr(0xE082),
    chr(0xE082): chr(0xE0B0),
    chr(0xE0B0): "あ",
    #い→ぃ→い゛→ぃ゛→い
    "い": "ぃ",
    "ぃ": chr(0xE083),
    chr(0xE083): chr(0xE0B1),
    chr(0xE0B1): "い",
    #う→ぅ→ゔ→ぅ゛→う
    "う": "ぅ",
    "ぅ": "ゔ",
    "ゔ": chr(0xE0B2),
    chr(0xE0B2): "う",
    #え→ぇ→え゛→ぇ゛→え
    "え": "ぇ",
    "ぇ": chr(0xE084),
    chr(0xE084): chr(0xE0B3),
    chr(0xE0B3): "え",
    #お→ぉ→お゛→ぉ゛→お
    "お": "ぉ",
    "ぉ": chr(0xE085),
    chr(0xE085): chr(0xE0B4),
    chr(0xE0B4): "お",

    #か行
    "か": "が",
    "が": "か",
    "き": "ぎ",
    "ぎ": "き",
    "く": "ぐ",
    "ぐ": "く",
    "け": "げ",
    "げ": "け",
    "こ": "ご",
    "ご": "こ",

    #さ行
    "さ": "ざ",
    "ざ": "さ",
    "し": "じ",
    "じ": "し",
    "す": "ず",
    "ず": "す",
    "せ": "ぜ",
    "ぜ": "せ",
    "そ": "ぞ",
    "ぞ": "そ",

    #た行
    "た": "だ",
    "だ": "た",
    "ち": "ぢ",
    "ぢ": "ち",
    #つ→っ→づ→っ゛→つ
    "つ": "っ",
    "っ": "づ",
    "づ": chr(0xE0B7),
    chr(0xE0B7): "つ",
    "て": "で",
    "で": "て",
    "と": "ど",
    "ど": "と",

    #な行
    "な": chr(0xE09A),
    chr(0xE09A): "な",
    "に": chr(0xE09B),
    chr(0xE09B): "に",
    "ぬ": chr(0xE09C),
    chr(0xE09C): "ぬ",
    "ね": chr(0xE09D),
    chr(0xE09D): "ね",
    "の": chr(0xE09E),
    chr(0xE09E): "の",

    #は行
    "は": "ば",
    "ば": "ぱ",
    "ぱ": "は",
    "ひ": "び",
    "び": "ぴ",
    "ぴ": "ひ",
    "ふ": "ぶ",
    "ぶ": "ぷ",
    "ぷ": "ふ",
    "へ": "べ",
    "べ": "ぺ",
    "ぺ": "へ",
    "ほ": "ぼ",
    "ぼ": "ぽ",
    "ぽ": "ほ",

    #ま行
    "ま": chr(0xE09F),
    chr(0xE09F): "ま",
    "み": chr(0xE0A0),
    chr(0xE0A0): "み",
    "む": chr(0xE0A1),
    chr(0xE0A1): "む",
    "め": chr(0xE0A2),
    chr(0xE0A2): "め",
    "も": chr(0xE0A3),
    chr(0xE0A3): "も",

    #や行
    #や→ゃ→や゛→ゃ゛
    "や": "ゃ",
    "ゃ": chr(0xE0A4),
    chr(0xE0A4): chr(0xE0B8),
    chr(0xE0B8): "や",
    "ゆ": "ゅ",
    "ゅ": chr(0xE0A5),
    chr(0xE0A5): chr(0xE0B9),
    chr(0xE0B9): "ゆ",
    "よ": "ょ",
    "ょ": chr(0xE0A6),
    chr(0xE0A6): chr(0xE0BA),
    chr(0xE0BA): "よ",

    #ら行
    "ら": chr(0xE0A7),
    chr(0xE0A7): "ら",
    "り": chr(0xE0A8),
    chr(0xE0A8): "り",
    "る": chr(0xE0A9),
    chr(0xE0A9): "る",
    "れ": chr(0xE0AA),
    chr(0xE0AA): "れ",
    "ろ": chr(0xE0AB),
    chr(0xE0AB): "ろ",

    #わ行
    "わ": "ゎ",
    "ゎ": chr(0xE0AC),
    chr(0xE0AC): chr(0xE0BB),
    chr(0xE0BB): "わ",
    "ゐ": chr(0xE0AD),
    chr(0xE0AE): "ゐ",
    "ゑ": chr(0xE0AE),
    chr(0xE0AD): "ゑ",
    "を": chr(0xE0AF),
    chr(0xE0AF): "を",

    "ん": chr(0xE086),
    chr(0xE086): "ん",

    "ー": chr(0xE0DB),
    chr(0xE0DB): "ー"
})

key_dakuten = CustomKey(
    design=KeyDesign(
        label=TextLabel("小ﾞﾟ"),
        color=KeyColor.normal
    ),
    press_actions=[
        hiragana_replaceAction
    ],
    variations=[
        FlickVariationData(
            direction=FlickDirection.left,
            key=Variation(
                design=VariationDesign(TextLabel("ゐ")),
                press_actions=[
                    InputAction("ゐ")
                ],
            )
        ),
        FlickVariationData(
            direction=FlickDirection.top,
            key=Variation(
                design=VariationDesign(TextLabel("ア゙イ゙ヴ")),
                press_actions=[
                    MoveTabAction(tab_type=TabType.custom,
                                  text="sippori_dakuten_katakana")
                ],
            )
        ),
        FlickVariationData(
            direction=FlickDirection.right,
            key=Variation(
                design=VariationDesign(TextLabel("ゑ")),
                press_actions=[
                    InputAction("ゑ")
                ],
            )
        )
    ]
)
#キーを一覧する
hiragana_keys = [
    KeyData(specifier=GridFitSpecifier(0, 0), key=SystemKey(SystemKeyType.flick_star123_tab)),
    KeyData(specifier=GridFitSpecifier(0, 1), key=SystemKey(SystemKeyType.flick_abc_tab)),
    KeyData(specifier=GridFitSpecifier(0, 2), key=SystemKey(SystemKeyType.flick_hira_tab)),
    KeyData(specifier=GridFitSpecifier(0, 3), key=SystemKey(SystemKeyType.change_keyboard)),
    KeyData(specifier=GridFitSpecifier(1, 0), key=key_あ),
    KeyData(specifier=GridFitSpecifier(2, 0), key=key_か),
    KeyData(specifier=GridFitSpecifier(3, 0), key=key_さ),
    KeyData(specifier=GridFitSpecifier(1, 1), key=key_た),
    KeyData(specifier=GridFitSpecifier(2, 1), key=key_な),
    KeyData(specifier=GridFitSpecifier(3, 1), key=key_は),
    KeyData(specifier=GridFitSpecifier(1, 2), key=key_ま),
    KeyData(specifier=GridFitSpecifier(2, 2), key=key_や),
    KeyData(specifier=GridFitSpecifier(3, 2), key=key_ら),
    KeyData(specifier=GridFitSpecifier(1, 3), key=key_dakuten),
    KeyData(specifier=GridFitSpecifier(2, 3), key=key_わ),
    KeyData(specifier=GridFitSpecifier(3, 3), key=SystemKey(SystemKeyType.flick_kutoten)),
    KeyData(specifier=GridFitSpecifier(4, 0), key=CustomKey.flickDelete()),
    KeyData(specifier=GridFitSpecifier(4, 1), key=CustomKey.flickSpace()),
    KeyData(specifier=GridFitSpecifier(4, 2, width=1, height=2), key=SystemKey(SystemKeyType.enter)),
]

key_ア = CustomKey.flickSimpleInputs(
    center="ア",
    subs=list("イウエオ")
)
key_カ = CustomKey.flickSimpleInputs(
    center="カ",
    subs=list("キクケコ")
)
key_サ = CustomKey.flickSimpleInputs(
    center="サ",
    subs=list("シスセソ")
)
key_タ = CustomKey.flickSimpleInputs(
    center="タ",
    subs=list("チツテト")
)
key_ナ = CustomKey.flickSimpleInputs(
    center="ナ",
    subs=list("ニヌネノ")
)
key_ハ = CustomKey.flickSimpleInputs(
    center="ハ",
    subs=list("ヒフヘホ")
)
key_マ = CustomKey.flickSimpleInputs(
    center="マ",
    subs=list("ミムメモ")
)
key_ヤ = CustomKey.flickSimpleInputs(
    center="ヤ",
    subs=list("「ユ」ヨ")
)
key_ラ = CustomKey.flickSimpleInputs(
    center="ラ",
    subs=list("リルレロ")
)
key_ワ = CustomKey.flickSimpleInputs(
    center="ワ",
    subs=list("ヲンー")
)
katakana_replaceAction = ReplaceLastCharactersAction({
    #ア行
    #ア→ァ→ア゛→ァ゛→ア
    "ア": "ァ",
    "ァ": chr(0xE087),
    chr(0xE087): chr(0xE0CE),
    chr(0xE0CE): "ア",
    #イ→ィ→イ゛→ィ゛→イ
    "イ": "ィ",
    "ィ": chr(0xE088),
    chr(0xE088): chr(0xE0CF),
    chr(0xE0CF): "イ",
    #ウ→ゥ→ヴ→ゥ゛→ウ
    "ウ": "ゥ",
    "ゥ": "ヴ",
    "ヴ": chr(0xE0D0),
    chr(0xE0D0): "ウ",
    #エ→ェ→エ゛→ェ゛→エ
    "エ": "ェ",
    "ェ": chr(0xE089),
    chr(0xE089): chr(0xE0D1),
    chr(0xE0D1): "エ",
    #オ→ォ→オ゛→ォ゛→オ
    "オ": "ォ",
    "ォ": chr(0xE08A),
    chr(0xE08A): chr(0xE0D2),
    chr(0xE0D2): "オ",

    #カ行
    "カ": "ガ",
    "ガ": "カ",
    "キ": "ギ",
    "ギ": "キ",
    "ク": "グ",
    "グ": "ク",
    "ケ": "ゲ",
    "ゲ": "ケ",
    "コ": "ゴ",
    "ゴ": "コ",

    #サ行
    "サ": "ザ",
    "ザ": "サ",
    "シ": "ジ",
    "ジ": "シ",
    "ス": "ズ",
    "ズ": "ス",
    "セ": "ゼ",
    "ゼ": "セ",
    "ソ": "ゾ",
    "ゾ": "ソ",

    #タ行
    "タ": "ダ",
    "ダ": "タ",
    "チ": "ヂ",
    "ヂ": "チ",
    #ツ→ッ→ヅ→ッ゛→ツ
    "ツ": "ッ",
    "ッ": "ヅ",
    "ヅ": chr(0xE0D5),
    chr(0xE0D5): "ツ",
    "テ": "デ",
    "デ": "テ",
    "ト": "ド",
    "ド": "ト",

    #ナ行
    "ナ": chr(0xE0BC),
    chr(0xE0BC): "ナ",
    "ニ": chr(0xE0BD),
    chr(0xE0BD): "ニ",
    "ヌ": chr(0xE0BE),
    chr(0xE0BE): "ヌ",
    "ネ": chr(0xE0BF),
    chr(0xE0BF): "ネ",
    "ノ": chr(0xE0C0),
    chr(0xE0C0): "ノ",

    #ハ行
    "ハ": "バ",
    "バ": "パ",
    "パ": "ハ",
    "ヒ": "ビ",
    "ビ": "ピ",
    "ピ": "ヒ",
    "フ": "ブ",
    "ブ": "プ",
    "プ": "フ",
    "ヘ": "ベ",
    "ベ": "ペ",
    "ペ": "ヘ",
    "ホ": "ボ",
    "ボ": "ポ",
    "ポ": "ホ",

    #マ行
    "マ": chr(0xE0C1),
    chr(0xE0C1): "マ",
    "ミ": chr(0xE0C2),
    chr(0xE0C2): "ミ",
    "ム": chr(0xE0C3),
    chr(0xE0C3): "ム",
    "メ": chr(0xE0C4),
    chr(0xE0C4): "メ",
    "モ": chr(0xE0C5),
    chr(0xE0C5): "モ",

    #ヤ行
    #ヤ→ャ→ヤ゛→ャ゛
    "ヤ": "ャ",
    "ャ": chr(0xE0C6),
    chr(0xE0C6): chr(0xE0D6),
    chr(0xE0D6): "ヤ",
    "ユ": "ュ",
    "ュ": chr(0xE0C7),
    chr(0xE0C7): chr(0xE0D7),
    chr(0xE0D7): "ユ",
    "ヨ": "ョ",
    "ョ": chr(0xE0C8),
    chr(0xE0C8): chr(0xE0D8),
    chr(0xE0D8): "ヨ",

    #ラ行
    "ラ": chr(0xE0C9),
    chr(0xE0C9): "ラ",
    "リ": chr(0xE0CA),
    chr(0xE0CA): "リ",
    "ル": chr(0xE0CB),
    chr(0xE0CB): "ル",
    "レ": chr(0xE0CC),
    chr(0xE0CC): "レ",
    "ロ": chr(0xE0CD),
    chr(0xE0CD): "ロ",

    #ワ行
    "ワ": "ヮ",
    "ヮ": "ヷ",
    "ヷ": chr(0xE0D9),
    chr(0xE0D9): "ワ",
    "ヰ": "ヸ",
    "ヸ": "ヰ",
    "ヱ": "ヹ",
    "ヹ": "ヱ",
    "ヲ": "ヺ",
    "ヺ": "ヲ",

    "ン": chr(0xE08B),
    chr(0xE08B): "ン",

    "ー": chr(0xE0DB),
    chr(0xE0DB): "ー"
})

key_dakuten = CustomKey(
    design=KeyDesign(
        label=TextLabel("小ﾞﾟ"),
        color=KeyColor.normal
    ),
    press_actions=[
        katakana_replaceAction
    ],
    variations=[
        FlickVariationData(
            direction=FlickDirection.left,
            key=Variation(
                design=VariationDesign(TextLabel("ヰ")),
                press_actions=[
                    InputAction("ヰ")
                ],
            )
        ),
        FlickVariationData(
            direction=FlickDirection.top,
            key=Variation(
                design=VariationDesign(TextLabel("あ゙い゙ゔ")),
                press_actions=[
                    MoveTabAction(tab_type=TabType.custom,
                                  text="sippori_dakuten_hiragana")
                ],
            )
        ),
        FlickVariationData(
            direction=FlickDirection.right,
            key=Variation(
                design=VariationDesign(TextLabel("ヱ")),
                press_actions=[
                    InputAction("ヱ")
                ],
            )
        )
    ]
)
#キーを一覧する
katakana_keys = [
    KeyData(specifier=GridFitSpecifier(0, 0), key=SystemKey(SystemKeyType.flick_star123_tab)),
    KeyData(specifier=GridFitSpecifier(0, 1), key=SystemKey(SystemKeyType.flick_abc_tab)),
    KeyData(specifier=GridFitSpecifier(0, 2), key=SystemKey(SystemKeyType.flick_hira_tab)),
    KeyData(specifier=GridFitSpecifier(0, 3), key=SystemKey(SystemKeyType.change_keyboard)),
    KeyData(specifier=GridFitSpecifier(1, 0), key=key_ア),
    KeyData(specifier=GridFitSpecifier(2, 0), key=key_カ),
    KeyData(specifier=GridFitSpecifier(3, 0), key=key_サ),
    KeyData(specifier=GridFitSpecifier(1, 1), key=key_タ),
    KeyData(specifier=GridFitSpecifier(2, 1), key=key_ナ),
    KeyData(specifier=GridFitSpecifier(3, 1), key=key_ハ),
    KeyData(specifier=GridFitSpecifier(1, 2), key=key_マ),
    KeyData(specifier=GridFitSpecifier(2, 2), key=key_ヤ),
    KeyData(specifier=GridFitSpecifier(3, 2), key=key_ラ),
    KeyData(specifier=GridFitSpecifier(1, 3), key=key_dakuten),
    KeyData(specifier=GridFitSpecifier(2, 3), key=key_ワ),
    KeyData(specifier=GridFitSpecifier(3, 3), key=SystemKey(SystemKeyType.flick_kutoten)),
    KeyData(specifier=GridFitSpecifier(4, 0), key=CustomKey.flickDelete()),
    KeyData(specifier=GridFitSpecifier(4, 1), key=CustomKey.flickSpace()),
    KeyData(specifier=GridFitSpecifier(4, 2, width=1, height=2), key=SystemKey(SystemKeyType.enter)),
]


#カスタードオブジェクトを作成
sippori_dakuten_hiragana = Custard(
    identifier="sippori_dakuten_hiragana",
    language=Language.none,
    input_style=InputStyle.direct,
    metadata=Metadata(
        custard_version="1.0",
        display_name="しっぽり明朝濁点ひらがな",
    ),
    interface=Interface(
        key_style=KeyStyle.tenkey_style,
        key_layout=GridFitLayout(5, 4),
        keys=hiragana_keys
    )
)

#カスタードオブジェクトを作成
sippori_dakuten_katakana = Custard(
    identifier="sippori_dakuten_katakana",
    language=Language.none,
    input_style=InputStyle.direct,
    metadata=Metadata(
        custard_version="1.0",
        display_name="しっぽり明朝濁点カタカナ",
    ),
    interface=Interface(
        key_style=KeyStyle.tenkey_style,
        key_layout=GridFitLayout(5, 4),
        keys=katakana_keys
    )
)

CustardList([sippori_dakuten_hiragana, sippori_dakuten_katakana]).write(name="sippori_dakuten", allow_overwrite=True)