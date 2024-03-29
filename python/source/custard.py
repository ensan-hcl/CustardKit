from __future__ import annotations
from pathlib import Path
from .layout import *
from .keys import *
from .json import to_json
import json
from enum import Enum, unique


class CustardJSONEncoder(json.JSONEncoder):
    def default(self, o):
        if isinstance(o, Custard):
            return to_json(o)
        if isinstance(o, CustardList):
            return to_json(o.custards)
        # 他の型はdefaultのエンコード方式を使用
        return super(CustardJSONEncoder, self).default(o)


@unique
class Language(str, Enum):
    ja_JP = "ja_JP"
    en_US = "en_US"
    el_GR = "el_GR"
    none = "none"
    undefined = "undefined"


@unique
class InputStyle(str, Enum):
    direct = "direct"
    roman2kana = "roman2kana"


@unique
class KeyStyle(str, Enum):
    tenkey_style = "tenkey_style"
    pc_style = "pc_style"


class Interface(object):
    def __init__(self, key_layout: Layout, key_style: KeyStyle, keys: list[KeyData]):
        self.key_layout = key_layout
        self.key_style = key_style
        self.keys = keys


class Metadata(object):
    def __init__(self, custard_version: str, display_name: str):
        self.custard_version = custard_version
        self.display_name = display_name


class Custard(object):
    def __init__(self, identifier: str, language: Language, input_style: InputStyle, metadata: Metadata, interface: Interface):
        self.identifier = identifier
        self.language = language
        self.input_style = input_style
        self.metadata = metadata
        self.interface = interface

    def write(self, to: str = None, name: str = None, allow_overwrite: bool = False):
        """
        Custardファイルを出力する関数
        Parameters
        ----------
        to: str = None
            出力先のパスを指定
        name: str = None
            出力先のパスを指定しない場合にファイル名を指定
        allow_overwrite: bool = False
            上書きを許可するか否か
        """
        pass


class CustardList(object):
    def __init__(self, custards: list[Custard]):
        self.custards = custards

    def write(self, to: str = None, name: str = None, allow_overwrite: bool = False):
        """
        Custardファイルを出力する関数
        Parameters
        ----------
        to: str = None
            出力先のパスを指定
        name: str = None
            出力先のパスを指定しない場合にファイル名を指定
        allow_overwrite: bool = False
            上書きを許可するか否か
        """
        pass


def write(self, to: str = None, name: str = None, allow_overwrite: bool = False):
    if to is None:
        result_directory_path = Path('__file__').resolve().parent / 'results'
        if not result_directory_path.exists():
            result_directory_path.mkdir()
        if name is None:
            name = 'custard'
        target = result_directory_path / f'{name}.json'
        number = 1
        while target.exists() and not allow_overwrite:
            number += 1
            target = result_directory_path / f'{name}#{number}.json'
        to = str(target)

    with open(f"{to}", mode="w") as f:
        f.write(json.dumps(self, cls=CustardJSONEncoder, ensure_ascii=False))


Custard.write = write
CustardList.write = write
