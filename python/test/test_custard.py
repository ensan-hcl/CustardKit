import unittest
import sys
from pathlib import Path
sys.path.append(str(Path('__file__').resolve().parent))
from source.custard import *
from source.json import to_json


class TestCustard(unittest.TestCase):
    """test class of custard.py
    """

    def test_Interface(self):
        """test method for Interface
        """
        layout = GridFitLayout(5, 4)
        style = KeyStyle.tenkey_style
        key = KeyData(GridFitSpecifier(3, 3), SystemKey(
            SystemKeyType.flick_star123_tab))

        interface = Interface(layout, style, [key])
        expected_json = {
            "key_layout": to_json(layout),
            "key_style": style,
            "keys": [to_json(key)],
        }
        self.assertEqual(expected_json, to_json(interface))

    def test_Metadata(self):
        """test method for Metadata
        """
        metadata = Metadata("1.0", "アインシュタインロンポウ")
        expected_json = {
            "custard_version": "1.0",
            "display_name": "アインシュタインロンポウ",
        }
        self.assertEqual(expected_json, to_json(metadata))

    def test_Language(self):
        """test method for Language
        """
        actual = json.dumps(Language.el_GR)
        self.assertEqual("\"el_GR\"", actual)

        actual = json.dumps(Language.none)
        self.assertEqual("\"none\"", actual)

        actual = json.dumps(Language.ja_JP)
        self.assertEqual("\"ja_JP\"", actual)

        actual = json.dumps(Language.en_US)
        self.assertEqual("\"en_US\"", actual)

        actual = json.dumps(Language.undefined)
        self.assertEqual("\"undefined\"", actual)

    def test_InputStyle(self):
        """test method for InputStyle
        """
        actual = json.dumps(InputStyle.direct)
        self.assertEqual("\"direct\"", actual)

        actual = json.dumps(InputStyle.roman2kana)
        self.assertEqual("\"roman2kana\"", actual)

    def test_KeyStyle(self):
        """test method for KeyStyle
        """
        actual = json.dumps(KeyStyle.pc_style)
        self.assertEqual("\"pc_style\"", actual)

        actual = json.dumps(KeyStyle.tenkey_style)
        self.assertEqual("\"tenkey_style\"", actual)

    def test_Custard(self):
        """test method for Custard
        """
        layout = GridScrollLayout(ScrollDirection.horizontal, 4, 3.9)
        style = KeyStyle.pc_style
        key = KeyData(GridScrollSpecifier(134), SystemKey(
            SystemKeyType.change_keyboard))

        interface = Interface(layout, style, [key])
        metadata = Metadata("99.99", "全然善処")
        identifier = "zen^3sho!"
        language = Language.el_GR
        input_style = InputStyle.direct
        custard = Custard(
            identifier=identifier,
            language=language,
            input_style=input_style,
            metadata=metadata,
            interface=interface
        )

        expected_json = {
            "identifier": identifier,
            "language": language,
            "input_style": input_style,
            "metadata": to_json(metadata),
            "interface": to_json(interface)
        }
        self.assertEqual(expected_json, to_json(custard))


if __name__ == "__main__":
    unittest.main()
