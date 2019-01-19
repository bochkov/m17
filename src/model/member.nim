import times
import json

type
    Member* = object of RootObj
        id: int
        name: string
        text: string

proc newMember*(id: int, name, text: string) : Member =
    return Member(id: id, name: name, text: text)

proc toJson*(mem : Member) : JsonNode =
    return %* {
        "id": mem.id,
        "name": mem.name,
        "text": mem.text
    }