from source.json import to_json
from source.keys import *
import unittest
import sys
from pathlib import Path
sys.path.append(str(Path('__file__').resolve().parent))


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
        self.assertEqual(expected_json, to_json(specifier))

        specifier = GridFitSpecifier(5, 9, 2, 2)
        expected_json = {
            "x": 5,
            "y": 9,
            "width": 2,
            "height": 2
        }
        self.assertEqual(expected_json, to_json(specifier))

    def test_GridScrollSpecifier(self):
        """test method for GridScrollSpecifier
        """

        specifier = GridScrollSpecifier(42)
        expected_json = {
            "index": 42
        }
        self.assertEqual(expected_json, to_json(specifier))

    def test_CustomKey(self):
        """test method for CustomKey
        """
        design = KeyDesign(TextLabel("ティッシュ"), KeyColor.selected)
        press_actions = [
            MoveCursorAction(4),
            InputAction("虫眼鏡型麻酔銃")
        ]
        key = CustomKey(
            design=design,
            press_actions=press_actions,
        )
        expected_json = {
            "design": to_json(design),
            "press_actions": to_json(press_actions),
            "longpress_actions": to_json(LongpressAction()),
            "variations": [],
        }
        self.assertEqual(expected_json, to_json(key))

        design = KeyDesign(TextLabel("花粉症"), KeyColor.selected)
        press_actions = [
            MoveTabAction(tab_type=TabType.custom,
                          text="superstrongkeyboard"),
        ]
        variation_design = VariationDesign(TextLabel("アレジオン"))
        variation = Variation(variation_design, [], LongpressAction())

        key = CustomKey(
            design=design,
            press_actions=press_actions,
            longpress_actions=LongpressAction(),
            variations=[variation]
        )
        expected_json = {
            "design": to_json(design),
            "press_actions": to_json(press_actions),
            "longpress_actions": to_json(LongpressAction()),
            "variations": [to_json(variation)],
        }
        self.assertEqual(expected_json, to_json(key))

    def test_SystemKeyType(self):
        """test method for SystemKeyType
        """
        actual = json.dumps(SystemKeyType.change_keyboard)
        self.assertEqual("\"change_keyboard\"", actual)

        actual = json.dumps(SystemKeyType.flick_kogaki)
        self.assertEqual("\"flick_kogaki\"", actual)

        actual = json.dumps(SystemKeyType.flick_kutoten)
        self.assertEqual("\"flick_kutoten\"", actual)

        actual = json.dumps(SystemKeyType.flick_abc_tab)
        self.assertEqual("\"flick_abc_tab\"", actual)

        actual = json.dumps(SystemKeyType.flick_hira_tab)
        self.assertEqual("\"flick_hira_tab\"", actual)

        actual = json.dumps(SystemKeyType.flick_star123_tab)
        self.assertEqual("\"flick_star123_tab\"", actual)

        actual = json.dumps(SystemKeyType.enter)
        self.assertEqual("\"enter\"", actual)

    def test_SystemKey(self):
        """test method for SystemKey
        """

        key = SystemKey(SystemKeyType.flick_kogaki)
        expected_json = {
            "type": SystemKeyType.flick_kogaki
        }
        self.assertEqual(expected_json, to_json(key))

    def test_KeyData(self):
        """test method for KeyData
        """
        specifier = GridScrollSpecifier(3)
        key = SystemKey(SystemKeyType.flick_kogaki)
        key_data = KeyData(specifier, key)
        expected_json = {
            "specifier_type": specifier.type,
            "specifier": to_json(specifier),
            "key_type": key.type,
            "key": to_json(key)
        }
        self.assertEqual(expected_json, to_json(key_data))

        specifier = GridFitSpecifier(1, 2, 3, 4)
        key = CustomKey(
            KeyDesign(SystemImageLabel("sun"), KeyColor.selected), [])
        key_data = KeyData(specifier, key)
        expected_json = {
            "specifier_type": specifier.type,
            "specifier": to_json(specifier),
            "key_type": key.type,
            "key": to_json(key)
        }
        self.assertEqual(expected_json, to_json(key_data))

    def test_StaticKeys(self):
        """test method for flickSpace and flickDelete
        """
        flickSpace = CustomKey.flickSpace()
        self.assertEqual(flickSpace.design.label.text, "空白")
        self.assertEqual(flickSpace.design.color, KeyColor.special)
        self.assertEqual(to_json(flickSpace.press_actions),
                         [to_json(InputAction(" "))])
        self.assertEqual(to_json(flickSpace.longpress_actions.start), [
                         to_json(ToggleCursorBarAction())])
        self.assertEqual(flickSpace.longpress_actions.repeat, [])
        self.assertEqual(len(flickSpace.variations), 3)

        flickDelete = CustomKey.flickDelete()
        self.assertEqual(flickDelete.design.label.system_image, "delete.left")
        self.assertEqual(flickDelete.design.color, KeyColor.special)
        self.assertEqual(to_json(flickDelete.press_actions),
                         [to_json(DeleteAction(1))])
        self.assertEqual(flickDelete.longpress_actions.start, [])
        self.assertEqual(to_json(flickDelete.longpress_actions.repeat), [
                         to_json(DeleteAction(1))])
        self.assertEqual(len(flickDelete.variations), 1)

    def test_FlickSimpleInputs(self):
        """test method for flickSimpleInputs
        """
        inputs = CustomKey.flickSimpleInputs("裁判", subs=["冤罪", "贖罪", "脅迫罪"])
        self.assertEqual(inputs.design.label.text, "裁判")
        self.assertEqual(inputs.design.color, KeyColor.normal)
        self.assertEqual(to_json(inputs.press_actions),
                         [to_json(InputAction("裁判"))])
        self.assertEqual(inputs.longpress_actions.start, [])
        self.assertEqual(inputs.longpress_actions.repeat, [])

        self.assertEqual(len(inputs.variations), 3)

        self.assertEqual(inputs.variations[0].direction, FlickDirection.left)
        self.assertEqual(inputs.variations[0].key.design.label.text, "冤罪")
        self.assertEqual(to_json(inputs.variations[0].key.press_actions), [
                         to_json(InputAction("冤罪"))])

        self.assertEqual(inputs.variations[0].key.longpress_actions.start, [])
        self.assertEqual(inputs.variations[0].key.longpress_actions.repeat, [])

        self.assertEqual(inputs.variations[1].direction, FlickDirection.top)
        self.assertEqual(inputs.variations[1].key.design.label.text, "贖罪")
        self.assertEqual(to_json(inputs.variations[1].key.press_actions), [
                         to_json(InputAction("贖罪"))])
        self.assertEqual(inputs.variations[1].key.longpress_actions.start, [])
        self.assertEqual(inputs.variations[1].key.longpress_actions.repeat, [])

        self.assertEqual(inputs.variations[2].direction, FlickDirection.right)
        self.assertEqual(inputs.variations[2].key.design.label.text, "脅迫罪")
        self.assertEqual(to_json(inputs.variations[2].key.press_actions), [
                         to_json(InputAction("脅迫罪"))])

        self.assertEqual(inputs.variations[2].key.longpress_actions.start, [])
        self.assertEqual(inputs.variations[2].key.longpress_actions.repeat, [])

        inputs = CustomKey.flickSimpleInputs(
            "iOS", subs=["Android", "macOS", "Windows", "chromeOS"], centerLabel="OS")
        self.assertEqual(inputs.design.label.text, "OS")
        self.assertEqual(to_json(inputs.press_actions),
                         [to_json(InputAction("iOS"))])

        inputs = CustomKey.flickSimpleInputAndLabels(
            center = ("やゆよ", "や"), 
            top = "ゆ",
            bottom = "よ"    
        )
        self.assertEqual(inputs.design.label.text, "やゆよ")
        self.assertEqual(to_json(inputs.press_actions),
                         [to_json(InputAction("や"))])
        self.assertEqual(inputs.longpress_actions.start, [])
        self.assertEqual(inputs.longpress_actions.repeat, [])

        self.assertEqual(len(inputs.variations), 2)

        self.assertEqual(inputs.variations[0].direction, FlickDirection.top)
        self.assertEqual(inputs.variations[0].key.design.label.text, "ゆ")
        self.assertEqual(to_json(inputs.variations[0].key.press_actions), [
                         to_json(InputAction("ゆ"))])

        self.assertEqual(inputs.variations[0].key.longpress_actions.start, [])
        self.assertEqual(inputs.variations[0].key.longpress_actions.repeat, [])

        self.assertEqual(inputs.variations[1].direction, FlickDirection.bottom)
        self.assertEqual(inputs.variations[1].key.design.label.text, "よ")
        self.assertEqual(to_json(inputs.variations[1].key.press_actions), [
                         to_json(InputAction("よ"))])
        self.assertEqual(inputs.variations[1].key.longpress_actions.start, [])
        self.assertEqual(inputs.variations[1].key.longpress_actions.repeat, [])

if __name__ == "__main__":
    unittest.main()
