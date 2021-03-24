import unittest
import sys
from pathlib import Path
sys.path.append(str(Path('__file__').resolve().parent))
from source.variations import *


class TestVariations(unittest.TestCase):
    """test class of variations.py
    """
    design = VariationDesign(SystemImageLabel("azooKey"))
    press_actions = [
        action_toggle_caps_lock_state(),
        action_move_cursor(-4),
        action_move_tab(TabType.custom, "flick_greek")
    ]
    start = [
        action_input("¡™£"),
        action_replace_last_characters(
            {"クレヨンしんちゃん": "ドラえもん", "妖怪ウォッチ": "ポケモン"}),
    ]
    repeat = [
        action_enable_resizing_mode(),
        action_smart_delete_default(),
    ]

    def test_Variation(self):
        """test method for Variation
        """
        longpress_actions = LongpressAction(self.start, self.repeat)
        variation = Variation(
            self.design, self.press_actions, longpress_actions)
        expected_json = {
            "design": self.design.json(),
            "press_actions": self.press_actions,
            "longpress_actions": longpress_actions.json(),
        }
        self.assertEqual(expected_json, variation.json())

    def test_FlickVariationData(self):
        """test method for FlickVariationData
        """
        longpress_actions = LongpressAction(self.start, self.repeat)
        variation = Variation(
            self.design, self.press_actions, longpress_actions)
        data = FlickVariationData(FlickDirection.bottom, variation)
        expected_json = {
            "type": "flick_variation",
            "direction": FlickDirection.bottom,
            "key": variation.json()
        }
        self.assertEqual(expected_json, data.json())

    def test_LongpressVariationData(self):
        """test method for LongpressVariationData
        """
        longpress_actions = LongpressAction(self.start, self.repeat)
        variation = Variation(
            self.design, self.press_actions, longpress_actions)
        data = LongpressVariationData(variation)
        expected_json = {
            "type": "longpress_variation",
            "key": variation.json()
        }
        self.assertEqual(expected_json, data.json())


if __name__ == "__main__":
    unittest.main()