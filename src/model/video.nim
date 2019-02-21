import json

type
    Video* = object of RootObj
        id: int
        iframe, desc: string

proc newVideo*(id: int, iframe, desc : string) : Video =
    return Video(id: id, iframe: iframe, desc: desc)

proc toJson*(v : Video) : JsonNode =
    return %* {
        "id": v.id,
        "iframe": v.iframe,
        "desc": v.desc
    }