from enum import Enum

def to_json_list(jsonable_list):
    return list(map(lambda item: to_json(item), jsonable_list))

def _make_json(dict):
    json = {}
    for key in dict:
        value = dict[key]
        if key.startswith('_'): continue
        if callable(value): continue
        json[key] = to_json(value)
    return json

def to_json(value):
    if isinstance(value, Enum):
        return value
    elif hasattr(value, '__dict__'):
        json = {
            **_make_json(value.__dict__),
            **_make_json(value.__class__.__dict__)
        }
        return json
    elif isinstance(value, list):
        return to_json_list(value)
    return value
