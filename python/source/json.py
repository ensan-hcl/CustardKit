from enum import Enum
import collections

_ignore_funcs = []
def ignore_json(func):
    """
    デコレーター修飾されたメソッドをjsonに含まない際に利用するデコレーター。
    デコレーターが複数ある際は、他のjson系以外のデコレーターより上部にくるように指定する。
    例：@propertyと@rename_jsonと@ignore_jsonがある時：@propertyを一番下にする。
    @ignore_jsonと@rename_jsonの順序は問わない。
    """
    _ignore_funcs.append(func)
    return func

_rename_funcs = {}
def rename_json(export_name):
    """
    デコレーター修飾されたメソッドをjsonに含む際に、キー名を変更するデコレーター。
    デコレーターが複数ある際は、他のjson系以外のデコレーターより上部にくるように指定する。
    例：@propertyと@rename_jsonと@ignore_jsonがある時：@propertyを一番下にする。
    @ignore_jsonと@rename_jsonの順序は問わない。
    """
    def _rename_json(func):
        _rename_funcs[func] = export_name
        return func
    return _rename_json

def _make_json(dict, instance):
    json = {}
    for key in dict:
        value = dict[key]
        if value in _ignore_funcs: continue
        if key.startswith('_'): continue
        if callable(value): continue
        if isinstance(value, collections.Hashable) and value in _rename_funcs:
            json[_rename_funcs[value]] = _to_json(value, instance)
        else:
            json[key] = _to_json(value, instance)
    return json

def _to_json(value, instance = None):
    if isinstance(value, Enum):
        return value
    elif isinstance(value, list):
        return list(map(lambda item: _to_json(item, instance), value))
    elif not instance is None and isinstance(value, property):
        return value.__get__(instance)
    elif hasattr(value, '__dict__'):
        return {
            **_make_json(value.__dict__, value),
            **_make_json(value.__class__.__dict__, value)
        }
    return value

def to_json(value):
    """
    あらゆるものを、JSON Serializableにする。
    Enumはそのまま維持されるので、JSONになるわけではない。
    クラスのインスタンスは、メンバー変数・デコレーター修飾されたメソッド(propertyなど)が書き出される。
    普通のメソッドは書きだされない。
    ※_で名前が開始されるメンバーなどは書きだされない。

    Parameters
    ----------
    value: Any
        JSON Serializableにするもの。
    """
    return _to_json(value)