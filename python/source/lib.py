from enum import Enum
import collections

_ignore_funcs = []
def ignore_json(func):
    _ignore_funcs.append(func)
    return func

_rename_funcs = {}
def rename_json(export_name):
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
            json[_rename_funcs[value]] = to_json(value, instance)
        else:
            json[key] = to_json(value, instance)
    return json

def to_json(value, instance = None):
    if isinstance(value, Enum):
        return value
    elif isinstance(value, list):
        return list(map(lambda item: to_json(item, instance), value))
    elif not instance is None and isinstance(value, property):
        return value.__get__(instance)
    elif hasattr(value, '__dict__'):
        return {
            **_make_json(value.__dict__, value),
            **_make_json(value.__class__.__dict__, value)
        }
    return value
