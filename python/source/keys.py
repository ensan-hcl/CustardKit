from __future__ import annotations
import json
from .variations import *
from .design import *
from .actions import *
from .json import ignore_json, rename_json
from enum import Enum, unique
from typing import Union


class Specifier(object):
    pass


class GridFitSpecifier(Specifier):
    @ignore_json
    @property
    def type(self):
        return "grid_fit"

    def __init__(self, x: int, y: int, width: int = 1, height: int = 1):
        self.x = x
        self.y = y
        self.width = width
        self.height = height


class GridScrollSpecifier(Specifier):
    @ignore_json
    @property
    def type(self):
        return "grid_scroll"

    def __init__(self, index: int):
        self.index = index


class Key(object):
    pass


class CustomKey(Key):
    @ignore_json
    @property
    def type(self): return "custom"

    def __init__(self, design: KeyDesign, press_actions: list[Action], longpress_actions: LongpressAction = LongpressAction(), variations: list[VariationData] = []):
        self.design = design
        self.press_actions = press_actions
        self.longpress_actions = longpress_actions
        self.variations = variations

    #utility
    @ignore_json
    @staticmethod
    def flickSimpleInputs(center: str, subs: list[str], centerLabel: str = None):
        variations: [FlickVariationData] = []
        for (letter, direction) in zip(subs, [FlickDirection.left, FlickDirection.top, FlickDirection.right, FlickDirection.bottom]):
            variations.append(
                FlickVariationData(
                    direction=direction,
                    key=Variation(
                        design=VariationDesign(TextLabel(letter)),
                        press_actions=[
                            InputAction(letter)
                        ]
                    )
                )
            )

        if centerLabel is None:
            centerLabel = center

        return CustomKey(
            design=KeyDesign(TextLabel(centerLabel), KeyColor.normal),
            press_actions=[
                InputAction(center)
            ],
            variations=variations
        )

    #utility
    @ignore_json
    @staticmethod
    def flickSimpleInputAndLabels(center: Union[tuple[str, str], str], left: Union[tuple[str, str], str, None] = None, top: Union[tuple[str, str], str, None] = None, right: Union[tuple[str, str], str, None] = None, bottom: Union[tuple[str, str], str, None] = None):
        variations: [FlickVariationData] = []
        for (argument, direction) in zip([left, top, right, bottom], [FlickDirection.left, FlickDirection.top, FlickDirection.right, FlickDirection.bottom]):
            if type(argument) is tuple:
                label = argument[0]
                input = argument[1]
            elif type(argument) is str:
                label = argument
                input = argument
            else:
                continue
            variations.append(
                FlickVariationData(
                    direction=direction,
                    key=Variation(
                        design=VariationDesign(TextLabel(label)),
                        press_actions=[
                            InputAction(input)
                        ]
                    )
                )
            )

        if type(center) is tuple:
            label = center[0]
            input = center[1]
        elif type(center) is str:
            label = center
            input = center

        return CustomKey(
            design=KeyDesign(TextLabel(label), KeyColor.normal),
            press_actions=[
                InputAction(input)
            ],
            variations=variations
        )

    #utility
    @ignore_json
    @staticmethod
    def flickDelete():
        return CustomKey(
            design=KeyDesign(SystemImageLabel(
                "delete.left"), KeyColor.special),
            press_actions=[DeleteAction(1)],
            longpress_actions=LongpressAction(repeat=[DeleteAction(1)]),
            variations=[
                FlickVariationData(
                    FlickDirection.left,
                    Variation(
                        design=VariationDesign(SystemImageLabel("xmark")),
                        press_actions=[SmartDeleteDefaultAction()]
                    )
                )
            ]
        )

    #utility
    @ignore_json
    @staticmethod
    def flickSpace():
        return CustomKey(
            design=KeyDesign(TextLabel("空白"), KeyColor.special),
            press_actions=[InputAction(" ")],
            longpress_actions=LongpressAction(
                start=[ToggleCursorBarAction()]),
            variations=[
                FlickVariationData(
                    FlickDirection.left,
                    Variation(
                        design=VariationDesign(TextLabel("←")),
                        press_actions=[MoveCursorAction(-1)],
                        longpress_actions=LongpressAction(
                            repeat=[MoveCursorAction(-1)])
                    )
                ),
                FlickVariationData(
                    FlickDirection.top,
                    Variation(
                        design=VariationDesign(TextLabel("全角")),
                        press_actions=[InputAction("　")]
                    )
                ),
                FlickVariationData(
                    FlickDirection.bottom,
                    Variation(
                        design=VariationDesign(TextLabel("tab")),
                        press_actions=[InputAction("\t")]
                    )
                ),
            ]
        )


@unique
class SystemKeyType(str, Enum):
    change_keyboard = "change_keyboard"
    enter = "enter"
    flick_kogaki = "flick_kogaki"
    flick_kutoten = "flick_kutoten"
    flick_hira_tab = "flick_hira_tab"
    flick_abc_tab = "flick_abc_tab"
    flick_star123_tab = "flick_star123_tab"


class SystemKey(Key):
    @ignore_json
    @property
    def type(self): return "system"

    def __init__(self, identifier: SystemKeyType):
        self._identifier = identifier

    @rename_json("type")
    @property
    def identifier(self): return self._identifier


class KeyData(object):
    def __init__(self, specifier: Specifier, key: Key):
        self.specifier = specifier
        self.key = key

    @property
    def specifier_type(self): return self.specifier.type

    @property
    def key_type(self): return self.key.type
