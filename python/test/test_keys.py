import unittest
import sys
from pathlib import Path
sys.path.append(str(Path('__file__').resolve().parent))
from source.keys import *


class TestKeys(unittest.TestCase):
    """test class of keys.py
    """

    def test_GridFitSpecifier(self):
        """test method for GridFitSpecifier
        """
        specifier = GridFitSpecifier(3, 4)
        expected_json = {
            "x": 3,
            "y": 4,
            "width": 1,
            "height": 1
        }
        self.assertEqual(expected_json, specifier.json())

        specifier = GridFitSpecifier(5, 9, 2, 2)
        expected_json = {
            "x": 5,
            "y": 9,
            "width": 2,
            "height": 2
        }
        self.assertEqual(expected_json, specifier.json())

    def test_GridScrollSpecifier(self):
        """test method for GridScrollSpecifier
        """

        specifier = GridScrollSpecifier(42)
        expected_json = {
            "index": 42
        }
        self.assertEqual(expected_json, specifier.json())

    def test_CustomKey(self):
        """test method for CustomKey
        """
        design = KeyDesign(TextLabel("ティッシュ"), KeyColor.selected)
        key = CustomKey(
            design=design,
            press_actions=[],
        )
        expected_json = {
            "design": design.json(),
            "press_actions": [],
            "longpress_actions": LongpressAction().json(),
            "variations": [],
        }
        self.assertEqual(expected_json, key.json())

        design = KeyDesign(TextLabel("花粉症"), KeyColor.selected)
        variation_design = VariationDesign(TextLabel("アレジオン"))
        variation = Variation(variation_design, [], LongpressAction())

        key = CustomKey(
            design=design,
            press_actions=[],
            longpress_actions=LongpressAction(),
            variations=[variation]
        )
        expected_json = {
            "design": design.json(),
            "press_actions": [],
            "longpress_actions": LongpressAction().json(),
            "variations": [variation.json()],
        }
        self.assertEqual(expected_json, key.json())

    def test_SystemKey(self):
        """test method for SystemKey
        """

        key = SystemKey(SystemKeyType.flick_kogaki)
        expected_json = {
            "type": SystemKeyType.flick_kogaki
        }
        self.assertEqual(expected_json, key.json())

    def test_KeyData(self):
        """test method for KeyData
        """
        specifier = GridScrollSpecifier(3)
        key = SystemKey(SystemKeyType.flick_kogaki)
        key_data = KeyData(specifier, key)
        expected_json = {
            "specifier_type": specifier.type,
            "specifier": specifier.json(),
            "key_type": key.type,
            "key": key.json()
        }
        self.assertEqual(expected_json, key_data.json())

        specifier = GridFitSpecifier(1, 2, 3, 4)
        key = CustomKey(
            KeyDesign(SystemImageLabel("sun"), KeyColor.selected), [])
        key_data = KeyData(specifier, key)
        expected_json = {
            "specifier_type": specifier.type,
            "specifier": specifier.json(),
            "key_type": key.type,
            "key": key.json()
        }
        self.assertEqual(expected_json, key_data.json())


if __name__ == "__main__":
    unittest.main()
