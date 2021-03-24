import unittest
import sys
from pathlib import Path
sys.path.append(str(Path('__file__').resolve().parent))
from source.actions import *


class TestActions(unittest.TestCase):
    """test class of actions.py
    """

    def test_action_input(self):
        """test method for action_input
        """
        actual = action_input("hoge😊√異")
        expected_json = {
            "type": "input",
            "text": "hoge😊√異"
        }
        self.assertEqual(expected_json, actual)

    def test_action_replace_last_characters(self):
        """test method for action_replace_last_characters
        """
        actual = action_replace_last_characters({"あ": "ぁ", "か": "が", "😆": "😭"})
        expected_json = {
            "type": "replace_last_characters",
            "table": {"あ": "ぁ", "か": "が", "😆": "😭"}
        }
        self.assertEqual(expected_json, actual)

    def test_action_move_tab(self):
        """test method for action_move_tab
        """
        actual = action_move_tab(tab_type=TabType.custom, text="flick_greek")
        expected_json = {
            "type": "move_tab",
            "tab_type": TabType.custom,
            "identifier": "flick_greek"
        }
        self.assertEqual(expected_json, actual)

        actual = action_move_tab(tab_type=TabType.system, text="flick_kutoten")
        expected_json = {
            "type": "move_tab",
            "tab_type": TabType.system,
            "identifier": "flick_kutoten"
        }
        self.assertEqual(expected_json, actual)

    def test_action_move_cursor(self):
        """test method for action_move_cursor
        """
        actual = action_move_cursor(3)
        expected_json = {
            "type": "move_cursor",
            "count": 3
        }
        self.assertEqual(expected_json, actual)

        actual = action_move_cursor(-2)
        expected_json = {
            "type": "move_cursor",
            "count": -2
        }
        self.assertEqual(expected_json, actual)

    def test_action_smart_move_cursor(self):
        """test method for action_smart_move_cursor
        """
        actual = action_smart_move_cursor(ScanDirection.forward, targets=[
                                          "!", "?", ".", ",", ":", ";"])
        expected_json = {
            "type": "smart_move_cursor",
            "direction": ScanDirection.forward,
            "targets": ["!", "?", ".", ",", ":", ";"]
        }
        self.assertEqual(expected_json, actual)

    def test_action_delete(self):
        """test method for action_delete
        """
        actual = action_delete(12)
        expected_json = {
            "type": "delete",
            "count": 12,
        }
        self.assertEqual(expected_json, actual)

        actual = action_delete(-4)
        expected_json = {
            "type": "delete",
            "count": -4,
        }
        self.assertEqual(expected_json, actual)

    def test_action_smart_delete(self):
        """test method for action_smart_delete
        """
        actual = action_smart_delete(ScanDirection.forward, targets=[
                                     "!", "?", ".", ",", ":", ";"])
        expected_json = {
            "type": "smart_delete",
            "direction": ScanDirection.forward,
            "targets": ["!", "?", ".", ",", ":", ";"]
        }
        self.assertEqual(expected_json, actual)

    def test_action_no_arguments(self):
        """test method for actions without arguments
        """
        actual = action_replace_default()
        expected_json = {
            "type": "replace_default",
        }
        self.assertEqual(expected_json, actual)

        actual = action_smart_delete_default()
        expected_json = {
            "type": "smart_delete_default",
        }
        self.assertEqual(expected_json, actual)

        actual = action_enable_resizing_mode()
        expected_json = {
            "type": "enable_resizing_mode",
        }
        self.assertEqual(expected_json, actual)

        actual = action_toggle_cursor_bar()
        expected_json = {
            "type": "toggle_cursor_bar",
        }
        self.assertEqual(expected_json, actual)

        actual = action_toggle_tab_bar()
        expected_json = {
            "type": "toggle_tab_bar",
        }
        self.assertEqual(expected_json, actual)

        actual = action_toggle_caps_lock_state()
        expected_json = {
            "type": "toggle_caps_lock_state",
        }
        self.assertEqual(expected_json, actual)

        actual = action_dismiss_keyboard()
        expected_json = {
            "type": "dismiss_keyboard",
        }
        self.assertEqual(expected_json, actual)

    def test_LongpressAction(self):
        """test method for LongpressAction
        """

        input = action_input("happy")
        delete = action_delete(-1)
        smart_move_cursor = action_smart_move_cursor(
            ScanDirection.backward, targets=["0"])
        dismiss_keyboard = action_dismiss_keyboard
        action = LongpressAction(start=[input, delete], repeat=[
                                 smart_move_cursor, dismiss_keyboard])

        expected_json = {
            "start": [input, delete],
            "repeat": [smart_move_cursor, dismiss_keyboard]
        }

        self.assertEqual(expected_json, action.json())

    def test_ScanDirection(self):
        """test method for ScanDirection
        """
        actual = json.dumps(ScanDirection.backward)
        self.assertEqual("\"backward\"", actual)

        actual = json.dumps(ScanDirection.forward)
        self.assertEqual("\"forward\"", actual)

    def test_TabType(self):
        """test method for TabType
        """
        actual = json.dumps(TabType.system)
        self.assertEqual("\"system\"", actual)

        actual = json.dumps(TabType.custom)
        self.assertEqual("\"custom\"", actual)


if __name__ == "__main__":
    unittest.main()
