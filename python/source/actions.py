import json
from enum import Enum, unique
from abc import ABCMeta, abstractmethod


class ActionDefaultArguments:
    scan_targets = ["、", "。", "！", "？", ".", ",", "．", "，", "\n"]


@unique
class ScanDirection(str, Enum):
    forward = "forward"
    backward = "backward"

class Action(metaclass=ABCMeta):
    @abstractmethod
    def json(self): pass

class InputAction(Action):
    def __init__(self, text: str):
        """
        文字を入力するアクション
        Parameters
        ----------
        text: str
            入力する文字
        """
        self.text = text

    def json(self):
        return {
            "type": "input",
            "text": self.text
        }

class ReplaceLastCharactersAction(Action):
    def __init__(self, table: dict[str, str]):
        """
        最後の文字を置換するアクション
        Parameters
        ----------
        table: dict[str, str]
            置換に用いるテーブル
        """
        self.table = table

    def json(self):
        return {
            "type": "replace_last_characters",
            "table": self.table
        }

class ReplaceDefaultAction(Action):
    def json(self):
        """
        azooKeyデフォルトの置換アクション
        """
        return {
            "type": "replace_default"
        }

@unique
class TabType(str, Enum):
    system = "system"
    custom = "custom"

class MoveTabAction(Action):
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
        self.text = text

    def json(self):
        return {
            "type": "move_tab",
            "tab_type": self.tab_type,
            "identifier": self.text
        }

class MoveCursorAction(Action):
    def __init__(self, count: int):
        """
        カーソルを移動するアクション
        Parameters
        ----------
        count: int
            移動する文字数。負の値を指定した場合文頭方向に移動。
        """
        self.count = count

    def json(self):
        return {
            "type": "move_cursor",
            "count": self.count
        }

class SmartMoveCursorAction(Action):
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

    def json(self):
        return {
            "type": "smart_move_cursor",
            "direction": self.direction,
            "targets": self.targets
        }

class DeleteAction(Action):
    def __init__(self, count: int):
        """
        文字を削除するアクション
        Parameters
        ----------
        count: int
            削除する文字数。負の値を指定した場合は文末方向の文字を削除。
        """
        self.count = count

    def json(self):
        return {
            "type": "delete",
            "count": self.count
        }

class SmartDeleteAction(Action):
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

    def json(self):
        return {
            "type": "smart_delete",
            "direction": self.direction,
            "targets": self.targets
        }

class SmartDeleteDefaultAction(Action):
    """
    azooKeyデフォルトの文頭まで削除アクション
    """

    def json(self):
        return {
            "type": "smart_delete_default"
        }

class EnableResizingModeAction(Action):
    """
    片手モードの調整を始めるアクション
    """
    def json(self):
        return {
            "type": "enable_resizing_mode"
        }

class ToggleCursorBarAction(Action):
    """
    カーソルバーの表示状態をtoggleするアクション
    """
    def json(self):
        return {
            "type": "toggle_cursor_bar"
        }

class ToggleTabBarAction(Action):
    """
    タブバーの表示状態をtoggleするアクション
    """
    def json(self):
        return {
            "type": "toggle_tab_bar"
        }

class ToggleCapsLockStateAction(Action):
    """
    Caps lockの状態をtoggleするアクション
    """
    def json(self):
        return {
            "type": "toggle_caps_lock_state"
        }

class DismissKeyboardAction(Action):
    """
    キーボードを閉じるアクション
    """
    def json(self):
        return {
            "type": "dismiss_keyboard"
        }

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
            "start": list(map(lambda action: action.json(), self.start)),
            "repeat": list(map(lambda action: action.json(), self.repeat))
        }
