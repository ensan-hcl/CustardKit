import unittest
import sys
from pathlib import Path
sys.path.append(str(Path('__file__').resolve().parent))
from source.layout import *


class TestLayout(unittest.TestCase):
    """test class of layout.py
    """

    def test_GridFitLayout(self):
        """test method for GridFitLayout
        """
        layout = GridFitLayout(0, 1)
        expected_json = {
            "type": "grid_fit",
            "row_count": 0,
            "column_count": 1
        }
        self.assertEqual(expected_json, layout.json())

    def test_GridScrollLayout(self):
        """test method for GridScrollLayout
        """
        layout = GridScrollLayout(
            ScrollDirection.vertical, row_count=8, column_count=4.2)
        expected_json = {
            "type": "grid_scroll",
            "direction": ScrollDirection.vertical,
            "row_count": 8,
            "column_count": 4.2
        }
        self.assertEqual(expected_json, layout.json())


if __name__ == "__main__":
    unittest.main()
