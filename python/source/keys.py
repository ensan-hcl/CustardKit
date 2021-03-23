import json
from .variations import *
from .design import *
from .actions import *
from enum import Enum, unique


class Specifier(object):
    pass


class GridFitSpecifier(Specifier):
    type = "grid_fit"
    x: int
    y: int
    width: int
    height: int

    def __init__(self, x: int, y: int, width: int = 1, height: int = 1):
        self.x = x
        self.y = y
        self.width = width
        self.height = height

    def value(self) -> dict:
        return {
            "x": self.x,
            "y": self.y,
            "width": self.width,
            "height": self.height
        }


class GridScrollSpecifier(Specifier):
    type = "grid_scroll"
    index: int

    def __init__(self, index: int):
        self.index = index

    def value(self) -> dict:
        return {
            "index": self.index,
        }


class Key(object):
    pass


class CustomKey(Key):
    type: str = "custom"
    design: KeyDesign
    press_actions: list[{str: str}]
    longpress_actions: LongpressAction
    variations: list[VariationData]

    def __init__(self, design: KeyDesign, press_actions: list[{str: str}], longpress_actions: LongpressAction = LongpressAction(), variations: list[VariationData] = []):
        self.design = design
        self.press_actions = press_actions
        self.longpress_actions = longpress_actions
        self.variations = variations

    def json(self) -> dict:
        return {
            "design": self.design.json(),
            "press_actions": self.press_actions,
            "longpress_actions": self.longpress_actions.json(),
            "variations": list(map(lambda variation: variation.json(), self.variations)),
        }


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
    identifier: SystemKeyType

    def __init__(self, identifier: SystemKeyType):
        self.identifier = identifier

    def json(self) -> dict:
        return {
            "type": self.identifier
        }


class KeyData(object):
    specifier: Specifier
    key: Key

    def __init__(self, specifier: Specifier, key: Key):
        self.specifier = specifier
        self.key = key

    def json(self) -> dict:
        return {
            "specifier_type": self.specifier.type,
            "specifier": self.specifier.value(),
            "key_type": self.key.type,
            "key": self.key.json()
        }
