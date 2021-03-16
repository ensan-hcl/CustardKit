from .layout import *
from .keys import *
import json

class CustardJSONEncoder(json.JSONEncoder):
    def default(self, o):
        if isinstance(o, Custard):
            return o.json()
            
        return super(CustardJSONEncoder, self).default(o) # 他の型はdefaultのエンコード方式を使用

class Interface(object):
    key_layout: Layout
    key_style: str
    keys: list[KeyData]

    def __init__(self, key_layout: Layout, key_style: str, keys: list[KeyData]):
        self.key_layout = key_layout
        self.key_style = key_style
        self.keys = keys

    def json(self) -> dict :
        return {
            "key_layout": self.key_layout.json(),
            "key_style": self.key_style,
            "keys": list(map(lambda key: key.json(), self.keys)),
        }

class Custard(object):  
    custard_version: str
    identifier: str
    display_name: str
    language: str
    input_style: str
    interface: Interface

    def __init__(self, custard_version: str, identifier: str, display_name: str, language: str, input_style: str, interface: Interface):
        self.custard_version = custard_version
        self.identifier = identifier
        self.display_name = display_name
        self.language = language
        self.input_style = input_style
        self.interface = interface

    def json(self) -> dict :
        return {
            "custard_version": self.custard_version,
            "identifier": self.identifier,
            "display_name": self.display_name,
            "language": self.language,
            "input_style": self.input_style,
            "interface": self.interface.json()
        }

    def write(self, to: str) -> dict :
        with open(f"{to}", mode="w") as f:
            f.write(json.dumps(self, cls = CustardJSONEncoder, ensure_ascii = False))
