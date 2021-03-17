import json
from enum import Enum, unique

class Layout(object): pass

class GridFitLayout(Layout):
    row_count: int
    column_count: int

    def __init__(self, row_count, column_count):
        self.row_count = row_count
        self.column_count = column_count

    def json(self) -> dict :
        return {
            "type": "grid_fit",
            "row_count": self.row_count,
            "column_count": self.column_count
        }

@unique 
class ScrollDirection(Enum):
    vertical = "vertical"
    horizontal = "horizontal"
    
    def json(self) -> dict :
        return self.value

class GridScrollLayout(Layout):
    direction: ScrollDirection
    row_count: float
    column_count: float

    def __init__(self, direction: ScrollDirection, row_count: float, column_count: float):
        self.direction = direction
        self.row_count = row_count
        self.column_count = column_count

    def json(self) -> dict :
        return {
            "type":  "grid_scroll",
            "direction": self.direction.json(),
            "row_count": self.row_count,
            "column_count": self.column_count
        }
