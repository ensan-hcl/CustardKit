import unittest
import sys
from pathlib import Path
sys.path.append(str(Path('__file__').resolve().parent))
from source.custard import *


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
            "key_layout": layout.json(),
            "key_style": style,
            "keys": [key.json()],
        }
        self.assertEqual(expected_json, interface.json())

    def test_Metadata(self):
        """test method for Metadata
        """
        metadata = Metadata("1.0", "アインシュタインロンポウ")
        expected_json = {
            "custard_version": "1.0",
            "display_name": "アインシュタインロンポウ",
        }
        self.assertEqual(expected_json, metadata.json())

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
            "metadata": metadata.json(),
            "interface": interface.json()
        }
        self.assertEqual(expected_json, custard.json())


if __name__ == "__main__":
    unittest.main()
