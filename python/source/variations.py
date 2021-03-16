import json
from .design import *
from .actions import *

class Variation(object):
    design: VariationDesign
    press_actions: list[{str: str}]
    longpress_actions: LongpressAction

    def __init__(self, design: KeyDesign, press_actions: list[{str: str}], longpress_actions: LongpressAction = LongpressAction()):
        self.design = design
        self.press_actions = press_actions
        self.longpress_actions = longpress_actions

    def json(self) -> dict :
        return {
            "design": self.design.json(),
            "press_actions": self.press_actions,
            "longpress_actions": self.longpress_actions.json(),
        }

class VariationData(object): pass

class FlickVariationData(VariationData):
    type = "flick_variation"
    direction: str
    key: Variation

    def __init__(self, direction: str, key: Variation):
        self.direction = direction
        self.key = key

    def json(self) -> dict :
        return {
            "type": self.type,
            "direction": self.direction,
            "key": self.key.json()
        }

class LongpressVariationData(VariationData):
    type = "longpress_variation"
    key: Variation

    def __init__(self, key: Variation):
        self.key = key

    def json(self) -> dict :
        return {
            "type": self.type,
            "key": self.key.json()
        }
