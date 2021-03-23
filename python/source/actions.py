import json
from enum import Enum, unique


@unique
class ScanDirection(str, Enum):
    forward = "forward"
    backward = "backward"


def action_input(text: str):
    """
    文字を入力するアクション
    Parameters
    ----------
    text: str
        入力する文字
    """
    return {
        "type": "input",
        "text": text
    }


def action_replace_last_characters(table: dict[str, str]):
    """
    最後の文字を置換するアクション
    Parameters
    ----------
    table: dict[str, str]
        置換に用いるテーブル
    """

    return {
        "type": "replace_last_characters",
        "table": table
    }


def action_replace_default():
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


def action_move_tab(tab_type: TabType, text: str):
    """
    タブを移動するアクション
    Parameters
    ----------
    tab_type: TabType
        タブのタイプ。"custom"または"system"を指定。
    text: str
        タブの識別子
    """

    return {
        "type": "move_tab",
        "tab_type": tab_type,
        "identifier": text
    }


def action_move_cursor(count: int):
    """
    カーソルを移動するアクション
    Parameters
    ----------
    count: int
        移動する文字数。負の値を指定した場合文頭方向に移動。
    """

    return {
        "type": "move_cursor",
        "count": count
    }


def action_smart_move_cursor(direction: ScanDirection, targets: list[str]):
    """
    指定した文字の隣までカーソルを移動するアクション
    Parameters
    ----------
    direction: ScanDirection
        移動の向きを"forward"または"backward"で指定。
    targets: list[str]
        停止条件となる文字のリスト。
    """

    return {
        "type": "smart_move_cursor",
        "direction": direction,
        "targets": targets
    }


def action_delete(count: int):
    """
    文字を削除するアクション
    Parameters
    ----------
    count: int
        削除する文字数。負の値を指定した場合は文末方向の文字を削除。
    """

    return {
        "type": "delete",
        "count": count
    }


def action_smart_delete(direction: ScanDirection, targets: list[str]):
    """
    指定した文字の隣まで文字を削除するアクション
    Parameters
    ----------
    direction: ScanDirection
        削除する向きを"forward"または"backward"で指定。
    targets: list[str]
        停止条件となる文字のリスト。
    """

    return {
        "type": "smart_delete",
        "direction": direction,
        "targets": targets
    }


def action_smart_delete_default():
    """
    azooKeyデフォルトの文頭まで削除アクション
    """

    return {
        "type": "smart_delete_default"
    }


def action_enable_resizing_mode():
    """
    片手モードの調整を始めるアクション
    """

    return {
        "type": "enable_resizing_mode"
    }


def action_toggle_cursor_bar():
    """
    カーソルバーの表示状態をtoggleするアクション
    """

    return {
        "type": "toggle_cursor_bar"
    }


def action_toggle_tab_bar():
    """
    タブバーの表示状態をtoggleするアクション
    """
    return {
        "type": "toggle_tab_bar"
    }


def action_toggle_caps_lock_state():
    """
    Caps lockの状態をtoggleするアクション
    """

    return {
        "type": "toggle_caps_lock_state"
    }


def action_dismiss_keyboard():
    """
    キーボードを閉じるアクション
    """

    return {
        "type": "dismiss_keyboard"
    }


class LongpressAction(object):
    start: list[dict]
    repeat: list[dict]

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
            "start": self.start,
            "repeat": self.repeat
        }
