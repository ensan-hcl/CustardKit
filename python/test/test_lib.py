import unittest
import sys
from pathlib import Path
sys.path.append(str(Path('__file__').resolve().parent))
from source.lib import *


class TestLib(unittest.TestCase):
    """test class of lib.py
    """

    def test_to_json_list(self):
        """test method for to_json_list
        """

        class SomeJSONableListItem:
            def __init__(self, index: int):
                self.index = index
            def json(self):
                return { "index": self.index }

        actual = to_json_list([
            SomeJSONableListItem(0), SomeJSONableListItem(5), SomeJSONableListItem(10)])
        expected_json = [
            { "index": 0 },
            { "index": 5 },
            { "index": 10 }
        ]
        self.assertEqual(expected_json, actual)

if __name__ == "__main__":
    unittest.main()
