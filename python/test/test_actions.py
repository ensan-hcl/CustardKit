import unittest
import sys
from pathlib import Path
sys.path.append(str(Path('__file__').resolve().parent))
from source.actions import *


class TestActions(unittest.TestCase):
    """test class of actions.py
    """

    def test_InputAction(self):
        """test method for InputAction
        """
        actual = InputAction("hoge😊√異").json()
        expected_json = {
            "type": "input",
            "text": "hoge😊√異"
        }
        self.assertEqual(expected_json, actual)

    def test_ReplaceLastCharactersAction(self):
        """test method for ReplaceLastCharactersAction
        """
        actual = ReplaceLastCharactersAction({"あ": "ぁ", "か": "が", "😆": "😭"}).json()
        expected_json = {
            "type": "replace_last_characters",
            "table": {"あ": "ぁ", "か": "が", "😆": "😭"}
        }
        self.assertEqual(expected_json, actual)

    def test_MoveTabAction(self):
        """test method for MoveTabAction
        """
        actual = MoveTabAction(tab_type=TabType.custom, text="flick_greek").json()
        expected_json = {
            "type": "move_tab",
            "tab_type": TabType.custom,
            "identifier": "flick_greek"
        }
        self.assertEqual(expected_json, actual)

        actual = MoveTabAction(tab_type=TabType.system, text="flick_kutoten").json()
        expected_json = {
            "type": "move_tab",
            "tab_type": TabType.system,
            "identifier": "flick_kutoten"
        }
        self.assertEqual(expected_json, actual)

    def test_MoveCursorAction(self):
        """test method for MoveCursorAction
        """
        actual = MoveCursorAction(3).json()
        expected_json = {
            "type": "move_cursor",
            "count": 3
        }
        self.assertEqual(expected_json, actual)

        actual = MoveCursorAction(-2).json()
        expected_json = {
            "type": "move_cursor",
            "count": -2
        }
        self.assertEqual(expected_json, actual)

    def test_SmartMoveCursorAction(self):
        """test method for SmartMoveCursorAction
        """
        actual = SmartMoveCursorAction(ScanDirection.forward, targets=[
                                          "!", "?", ".", ",", ":", ";"]).json()
        expected_json = {
            "type": "smart_move_cursor",
            "direction": ScanDirection.forward,
            "targets": ["!", "?", ".", ",", ":", ";"]
        }
        self.assertEqual(expected_json, actual)

    def test_DeleteAction(self):
        """test method for DeleteAction
        """
        actual = DeleteAction(12).json()
        expected_json = {
            "type": "delete",
            "count": 12,
        }
        self.assertEqual(expected_json, actual)

        actual = DeleteAction(-4).json()
        expected_json = {
            "type": "delete",
            "count": -4,
        }
        self.assertEqual(expected_json, actual)

    def test_SmartDeleteAction(self):
        """test method for SmartDeleteAction
        """
        actual = SmartDeleteAction(ScanDirection.forward, targets=[
                                     "!", "?", ".", ",", ":", ";"]).json()
        expected_json = {
            "type": "smart_delete",
            "direction": ScanDirection.forward,
            "targets": ["!", "?", ".", ",", ":", ";"]
        }
        self.assertEqual(expected_json, actual)

    def test_NoArgumentsAction(self):
        """test method for actions without arguments
        """
        actual = ReplaceDefaultAction().json()
        expected_json = {
            "type": "replace_default",
        }
        self.assertEqual(expected_json, actual)

        actual = SmartDeleteDefaultAction().json()
        expected_json = {
            "type": "smart_delete_default",
        }
        self.assertEqual(expected_json, actual)

        actual = EnableResizingModeAction().json()
        expected_json = {
            "type": "enable_resizing_mode",
        }
        self.assertEqual(expected_json, actual)

        actual = ToggleCursorBarAction().json()
        expected_json = {
            "type": "toggle_cursor_bar",
        }
        self.assertEqual(expected_json, actual)

        actual = ToggleTabBarAction().json()
        expected_json = {
            "type": "toggle_tab_bar",
        }
        self.assertEqual(expected_json, actual)

        actual = ToggleCapsLockStateAction().json()
        expected_json = {
            "type": "toggle_caps_lock_state",
        }
        self.assertEqual(expected_json, actual)

        actual = DismissKeyboardAction().json()
        expected_json = {
            "type": "dismiss_keyboard",
        }
        self.assertEqual(expected_json, actual)

    def test_LongpressAction(self):
        """test method for LongpressAction
        """

        input = InputAction("happy")
        delete = DeleteAction(-1)
        smart_move_cursor = SmartMoveCursorAction(
            ScanDirection.backward, targets=["0"])
        dismiss_keyboard = DismissKeyboardAction()
        action = LongpressAction(start=[input, delete], repeat=[
                                 smart_move_cursor, dismiss_keyboard])

        expected_json = {
            "start": [input.json(), delete.json()],
            "repeat": [smart_move_cursor.json(), dismiss_keyboard.json()]
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
