import json
from .variations import *
from .design import *
from .actions import *
from enum import Enum, unique


class Specifier(object):
    pass


class GridFitSpecifier(Specifier):
    type = "grid_fit"

    def __init__(self, x: int, y: int, width: int = 1, height: int = 1):
        self.x = x
        self.y = y
        self.width = width
        self.height = height

    def json(self) -> dict:
        return {
            "x": self.x,
            "y": self.y,
            "width": self.width,
            "height": self.height
        }


class GridScrollSpecifier(Specifier):
    type = "grid_scroll"

    def __init__(self, index: int):
        self.index = index

    def json(self) -> dict:
        return {
            "index": self.index,
        }


class Key(object):
    pass


class CustomKey(Key):
    type: str = "custom"

    def __init__(self, design: KeyDesign, press_actions: list[Action], longpress_actions: LongpressAction = LongpressAction(), variations: list[VariationData] = []):
        self.design = design
        self.press_actions = press_actions
        self.longpress_actions = longpress_actions
        self.variations = variations

    def json(self) -> dict:
        return {
            "design": self.design.json(),
            "press_actions": list(map(lambda action: action.json(), self.press_actions)),
            "longpress_actions": self.longpress_actions.json(),
            "variations": list(map(lambda variation: variation.json(), self.variations)),
        }

    #utility

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
    type: str = "system"

    def __init__(self, identifier: SystemKeyType):
        self.identifier = identifier

    def json(self) -> dict:
        return {
            "type": self.identifier
        }


class KeyData(object):
    def __init__(self, specifier: Specifier, key: Key):
        self.specifier = specifier
        self.key = key

    def json(self) -> dict:
        return {
            "specifier_type": self.specifier.type,
            "specifier": self.specifier.json(),
            "key_type": self.key.type,
            "key": self.key.json()
        }
