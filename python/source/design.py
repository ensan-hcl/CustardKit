from __future__ import annotations
import json
from enum import Enum, unique


@unique
class KeyColor(str, Enum):
    normal = "normal"
    special = "special"
    selected = "selected"
    unimportant = "unimportant"


class KeyLabel(object):
    pass


class TextLabel(KeyLabel):
    def __init__(self, text: str):
        self.text = text

class SystemImageLabel(KeyLabel):
    def __init__(self, identifier: str):
        self.system_image = identifier


class KeyDesign:
    def __init__(self, label: KeyLabel, color: KeyColor):
        self.label = label
        self.color = color


class VariationDesign:
    def __init__(self, label: KeyLabel):
        self.label = label
