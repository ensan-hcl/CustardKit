import json
from enum import Enum, unique

@unique 
class KeyColor(str, Enum):
    normal = "normal"
    special = "special"
    selected = "selected"

class KeyLabel(object): pass

class TextLabel(KeyLabel):
    text: str

    def __init__(self, text: str):
        self.text = text

    def json(self) -> dict :
        return {
            "text": self.text
        }

class SystemImageLabel(KeyLabel):
    identifier: str

    def __init__(self, identifier: str):
        self.identifier = identifier

    def json(self) -> dict :
        return {
            "system_image": self.identifier
        }
        
class KeyDesign:
    label: KeyLabel
    color: str

    def __init__(self, label: KeyLabel, color: KeyColor):
        self.label = label
        self.color = color

    def json(self) -> dict :
        return {
            "label": self.label.json(),
            "color": self.color
        }

class VariationDesign:
    label: KeyLabel

    def __init__(self, label: KeyLabel):
        self.label = label

    def json(self) -> dict :
        return {
            "label": self.label.json()
        }
