from __future__ import annotations
import json
from enum import Enum, unique


class Layout(object):
    pass


class GridFitLayout(Layout):
    type: str = "grid_fit"

    def __init__(self, row_count, column_count):
        self.row_count = row_count
        self.column_count = column_count


@unique
class ScrollDirection(str, Enum):
    vertical = "vertical"
    horizontal = "horizontal"


class GridScrollLayout(Layout):
    type: str = "grid_scroll"

    def __init__(self, direction: ScrollDirection, row_count: float, column_count: float):
        self.direction = direction
        self.row_count = row_count
        self.column_count = column_count
