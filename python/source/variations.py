import json
from .design import *
from .actions import *
from enum import Enum, unique


class Variation(object):
    def __init__(self, design: VariationDesign, press_actions: list[Action], longpress_actions: LongpressAction = LongpressAction()):
        self.design = design
        self.press_actions = press_actions
        self.longpress_actions = longpress_actions

    def json(self) -> dict:
        return {
            "design": self.design.json(),
            "press_actions": list(map(lambda action: action.json(), self.press_actions)),
            "longpress_actions": self.longpress_actions.json(),
        }


class VariationData(object):
    pass


@unique
class FlickDirection(str, Enum):
    left = "left"
    top = "top"
    right = "right"
    bottom = "bottom"


class FlickVariationData(VariationData):
    type = "flick_variation"

    def __init__(self, direction: FlickDirection, key: Variation):
        self.direction = direction
        self.key = key

    def json(self) -> dict:
        return {
            "type": self.type,
            "direction": self.direction,
            "key": self.key.json()
        }


class LongpressVariationData(VariationData):
    type = "longpress_variation"

    def __init__(self, key: Variation):
        self.key = key

    def json(self) -> dict:
        return {
            "type": self.type,
            "key": self.key.json()
        }
