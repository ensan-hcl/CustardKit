import json
from .variations import *
from .design import *
from .actions import *

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

class SystemKey(Key): 
    type: str = "system"
    identifier: str

    def __init__(self, identifier: str):
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
