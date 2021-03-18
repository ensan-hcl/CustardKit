import json
from .variations import *
from .design import *
from .actions import *
from enum import Enum, unique

@unique 
class SpecifierType(str, Enum):
    grid_fit = "grid_fit"
    grid_scroll = "grid_scroll"

class Specifier(object):
    type: str
    value: dict
    def __init__(self, type: str, value: dict):
        self.type = type
        self.value = value

class Key(object): pass

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

    def json(self) -> dict :
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

    def json(self) -> dict :
        return {
            "type": self.identifier
        }

class KeyData(object): 
    specifier: Specifier
    key: Key

    def __init__(self, specifier: Specifier, key: Key):
        self.specifier = specifier
        self.key = key

    def json(self) -> dict :
        return {
            "specifier_type": self.specifier.type,
            "specifier": self.specifier.value,
            "key_type": self.key.type,
            "key": self.key.json()
        }
