import json
from .lib import to_json_list, to_json
from enum import Enum, unique
from abc import ABCMeta, abstractmethod


class ActionDefaultArguments:
    scan_targets = ["、", "。", "！", "？", ".", ",", "．", "，", "\n"]


@unique
class ScanDirection(str, Enum):
    forward = "forward"
    backward = "backward"

class Action: pass

class ActionMeta(type):
    def __new__(meta, name, bases, attributes):
        bases = (Action,)
        if not "type" in attributes:
            raise TypeError("Action has no type!")
        return type.__new__(meta, name, bases, attributes)

class InputAction(metaclass=ActionMeta):
    type = "input"
    def __init__(self, text: str):
        """
        文字を入力するアクション
        Parameters
        ----------
        text: str
            入力する文字
        """
        self.text = text

class ReplaceLastCharactersAction(metaclass=ActionMeta):
    type = "replace_last_characters"
    def __init__(self, table: dict[str, str]):
        """
        最後の文字を置換するアクション
        Parameters
        ----------
        table: dict[str, str]
            置換に用いるテーブル
        """
        self.table = table

class ReplaceDefaultAction(metaclass=ActionMeta):
    """
    azooKeyデフォルトの置換アクション
    """
    type = "replace_default"

@unique
class TabType(str, Enum):
    system = "system"
    custom = "custom"

class MoveTabAction(metaclass=ActionMeta):
    type = "move_tab"
    def __init__(self, tab_type: TabType, text: str):
        """
        タブを移動するアクション
        Parameters
        ----------
        tab_type: TabType
            タブのタイプ。"custom"または"system"を指定。
        text: str
            タブの識別子
        """
        self.tab_type = tab_type
        self.identifier = text

class MoveCursorAction(metaclass=ActionMeta):
    type = "move_cursor"
    def __init__(self, count: int):
        """
        カーソルを移動するアクション
        Parameters
        ----------
        count: int
            移動する文字数。負の値を指定した場合文頭方向に移動。
        """
        self.count = count

class SmartMoveCursorAction(metaclass=ActionMeta):
    type = "smart_move_cursor"
    def __init__(self, direction: ScanDirection, targets: list[str]):
        """
        指定した文字の隣までカーソルを移動するアクション
        Parameters
        ----------
        direction: ScanDirection
            移動の向きを"forward"または"backward"で指定。
        targets: list[str]
            停止条件となる文字のリスト。
        """
        self.direction = direction
        self.targets = targets

class DeleteAction(metaclass=ActionMeta):
    type = "delete"
    def __init__(self, count: int):
        """
        文字を削除するアクション
        Parameters
        ----------
        count: int
            削除する文字数。負の値を指定した場合は文末方向の文字を削除。
        """
        self.count = count

class SmartDeleteAction(metaclass=ActionMeta):
    type = "smart_delete"
    def __init__(self, direction: ScanDirection, targets: list[str]):
        """
        指定した文字の隣まで文字を削除するアクション
        Parameters
        ----------
        direction: ScanDirection
            削除する向きを"forward"または"backward"で指定。
        targets: list[str]
            停止条件となる文字のリスト。
        """
        self.direction = direction
        self.targets = targets

class SmartDeleteDefaultAction(metaclass=ActionMeta):
    """
    azooKeyデフォルトの文頭まで削除アクション
    """
    type = "smart_delete_default"

class EnableResizingModeAction(metaclass=ActionMeta):
    """
    片手モードの調整を始めるアクション
    """
    type = "enable_resizing_mode"

class ToggleCursorBarAction(metaclass=ActionMeta):
    """
    カーソルバーの表示状態をtoggleするアクション
    """
    type = "toggle_cursor_bar"

class ToggleTabBarAction(metaclass=ActionMeta):
    """
    タブバーの表示状態をtoggleするアクション
    """
    type = "toggle_tab_bar"

class ToggleCapsLockStateAction(metaclass=ActionMeta):
    """
    Caps lockの状態をtoggleするアクション
    """
    type = "toggle_caps_lock_state"

class DismissKeyboardAction(metaclass=ActionMeta):
    """
    キーボードを閉じるアクション
    """
    type = "dismiss_keyboard"

class LongpressAction(object):
    def __init__(self, start: list[dict] = [], repeat: list[dict] = []):
        """
        イニシャライザ
        Parameters
        ----------
        start: list[dict] = []
            長押しが成立した段階で実行されるアクションのリスト
        repeat: list[dict] = []
            長押しが成立している間繰り返し実行されるアクションのリスト
        """

        self.start = start
        self.repeat = repeat

    def json(self) -> dict:
        return {
            "start": to_json_list(self.start),
            "repeat": to_json_list(self.repeat)
        }
