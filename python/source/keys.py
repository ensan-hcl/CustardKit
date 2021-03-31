import json
from .variations import *
from .design import *
from .actions import *
from .json import ignore_json, rename_json
from enum import Enum, unique


class Specifier(object):
    pass


class GridFitSpecifier(Specifier):
    @ignore_json
    @property
    def type(self):
        return "grid_fit"

    def __init__(self, x: int, y: int, width: int = 1, height: int = 1):
        self.x = x
        self.y = y
        self.width = width
        self.height = height


class GridScrollSpecifier(Specifier):
    @ignore_json
    @property
    def type(self):
        return "grid_scroll"

    def __init__(self, index: int):
        self.index = index


class Key(object):
    pass


class CustomKey(Key):
    @ignore_json
    @property
    def type(self): return "custom"

    def __init__(self, design: KeyDesign, press_actions: list[Action], longpress_actions: LongpressAction = LongpressAction(), variations: list[VariationData] = []):
        self.design = design
        self.press_actions = press_actions
        self.longpress_actions = longpress_actions
        self.variations = variations

    #utility
    @ignore_json
    @staticmethod
    def flickSimpleInputs(center: str, subs: list[str], centerLabel: str = None):
        variations: [FlickVariationData] = []
        for (letter, direction) in zip(subs, [FlickDirection.left, FlickDirection.top, FlickDirection.right, FlickDirection.bottom]):
            variations.append(
                FlickVariationData(
                    direction=direction,
                    key=Variation(
                        design=VariationDesign(TextLabel(letter)),
                        press_actions=[
                            InputAction(letter)
                        ]
                    )
                )
            )

        if centerLabel is None:
            centerLabel = center

        return CustomKey(
            design=KeyDesign(TextLabel(centerLabel), KeyColor.normal),
            press_actions=[
                InputAction(center)
            ],
            variations=variations
        )

    #utility
    @ignore_json
    @staticmethod
    def flickDelete():
        return CustomKey(
            design=KeyDesign(SystemImageLabel(
                "delete.left"), KeyColor.special),
            press_actions=[DeleteAction(1)],
            longpress_actions=LongpressAction(repeat=[DeleteAction(1)]),
            variations=[
                FlickVariationData(
                    FlickDirection.left,
                    Variation(
                        design=VariationDesign(SystemImageLabel("xmark")),
                        press_actions=[SmartDeleteDefaultAction()]
                    )
                )
            ]
        )

    #utility
    @ignore_json
    @staticmethod
    def flickSpace():
        return CustomKey(
            design=KeyDesign(TextLabel("空白"), KeyColor.special),
            press_actions=[InputAction(" ")],
            longpress_actions=LongpressAction(
                start=[ToggleCursorBarAction()]),
            variations=[
                FlickVariationData(
                    FlickDirection.left,
                    Variation(
                        design=VariationDesign(TextLabel("←")),
                        press_actions=[MoveCursorAction(-1)],
                        longpress_actions=LongpressAction(
                            repeat=[MoveCursorAction(-1)])
                    )
                ),
                FlickVariationData(
                    FlickDirection.top,
                    Variation(
                        design=VariationDesign(TextLabel("全角")),
                        press_actions=[InputAction("　")]
                    )
                ),
                FlickVariationData(
                    FlickDirection.bottom,
                    Variation(
                        design=VariationDesign(TextLabel("tab")),
                        press_actions=[InputAction("\t")]
                    )
                ),
            ]
        )


@unique
class SystemKeyType(str, Enum):
    change_keyboard = "change_keyboard"
    enter = "enter"
    flick_kogaki = "flick_kogaki"
    flick_kutoten = "flick_kutoten"
    flick_hira_tab = "flick_hira_tab"
    flick_abc_tab = "flick_abc_tab"
    flick_star123_tab = "flick_star123_tab"


class SystemKey(Key):
    @ignore_json
    @property
    def type(self): return "system"

    def __init__(self, identifier: SystemKeyType):
        self._identfier = identifier

    @rename_json("type")
    @property
    def identifier(self): return self._identfier


class KeyData(object):
    def __init__(self, specifier: Specifier, key: Key):
        self.specifier = specifier
        self.key = key

    @property
    def specifier_type(self): return self.specifier.type

    @property
    def key_type(self): return self.key.type
