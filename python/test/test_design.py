import unittest
import sys
from pathlib import Path
sys.path.append(str(Path('__file__').resolve().parent))
from source.design import *
from source.lib import to_json


class TestDesign(unittest.TestCase):
    """test class of design.py
    """

    def test_KeyColor(self):
        """test method for KeyColor
        """
        actual = json.dumps(KeyColor.normal)
        self.assertEqual("\"normal\"", actual)

        actual = json.dumps(KeyColor.special)
        self.assertEqual("\"special\"", actual)

        actual = json.dumps(KeyColor.selected)
        self.assertEqual("\"selected\"", actual)

    def test_TextLabel(self):
        """test method for TextLabel
        """
        label = TextLabel("hogefugapiyo")
        expected_json = {
            "text": "hogefugapiyo",
        }
        self.assertEqual(expected_json, to_json(label))

    def test_SystemImageLabel(self):
        """test method for SystemImageLabel
        """
        label = SystemImageLabel("azooKey")
        expected_json = {
            "system_image": "azooKey",
        }
        self.assertEqual(expected_json, to_json(label))

    def test_KeyDesign(self):
        """test method for KeyDesign
        """
        label = SystemImageLabel("azooKey")
        color = KeyColor.special
        key_design = KeyDesign(label, color)
        expected_json = {
            "label": to_json(label),
            "color": color
        }
        self.assertEqual(expected_json, to_json(key_design))

        label = TextLabel("😭😭😭")
        color = KeyColor.selected
        key_design = KeyDesign(label, color)
        expected_json = {
            "label": to_json(label),
            "color": color
        }
        self.assertEqual(expected_json, to_json(key_design))

    def test_VariationDesign(self):
        """test method for KeyDesign
        """
        label = SystemImageLabel("azooKey")
        design = VariationDesign(label)
        expected_json = {
            "label": to_json(label),
        }
        self.assertEqual(expected_json, to_json(design))

        label = TextLabel("😭😭😭")
        design = VariationDesign(label)
        expected_json = {
            "label": to_json(label),
        }
        self.assertEqual(expected_json, to_json(design))


if __name__ == "__main__":
    unittest.main()
