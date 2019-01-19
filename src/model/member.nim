import times
import json

type
    Member* = object of RootObj
        id: int
        name: string
        text: string
        order: int

proc newMember*(id: int, name, text: string, order: int) : Member =
    return Member(id: id, name: name, text: text, order: order)

proc toJson*(mem : Member) : JsonNode =
    return %* {
        "id": mem.id,
        "name": mem.name,
        "text": mem.text,
        "order": mem.order
    }