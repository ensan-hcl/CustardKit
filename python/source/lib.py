def to_json_list(jsonable_list):
    return list(map(lambda item: item.json(), jsonable_list))
