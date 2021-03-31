import unittest
import sys
from enum import unique, Enum
from pathlib import Path
sys.path.append(str(Path('__file__').resolve().parent))
from source.json import *


class TestJSON(unittest.TestCase):
    """test class of json.py
    """

    def test_to_json(self):
        self.assertEqual(10, to_json(10))
        self.assertEqual(1.2, to_json(1.2))
        self.assertEqual("hoge", to_json("hoge"))
        self.assertEqual(True, to_json(True))
        class SomeJSONableChild:
            def __init__(self):
                self.a = 100
                self.b = "hoge"
        class SomeJSONable:
            def __init__(self):
                self.child = SomeJSONableChild()
                self.a = True
                self.b = [100, "foo", False, { "a": "b" }]
            def fuga(): pass

        actual = to_json(SomeJSONable())
        expected_json = {
            "child": {
                "a": 100,
                "b": "hoge"
            },
            "a": True,
            "b": [100, "foo", False, { "a": "b" }]
        }
        self.assertEqual(expected_json, actual)

        @unique
        class SomeJSONableEnum(Enum):
            foo = "foo"
            bar = "bar"
        self.assertEqual(SomeJSONableEnum.foo, to_json(SomeJSONableEnum.foo))

        class SomeJSONableWithProperties:
            def __init__(self, uniqueId):
                self.uniqueId = uniqueId

            @property
            def twice(self): return self.uniqueId * 2

            @ignore_json
            @property
            def half(self): return self.uniqueId / 2

            @rename_json("1/4")
            @property
            def quarter(self): return self.uniqueId / 4

        actual = to_json(SomeJSONableWithProperties(12))
        expected_json = {
            "uniqueId": 12,
            "twice": 24,
            "1/4": 3
        }

        self.assertEqual(actual, expected_json)

if __name__ == "__main__":
    unittest.main()
