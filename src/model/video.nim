import json

type
    Video* = object
        id: int
        iframe: string
        desc: string

proc newVideo*(id: int, iframe, desc: string): Video =
    return Video(
        id: id,
        iframe: iframe,
        desc: desc
    )

proc `%`*(this: Video): JsonNode =
    return %* {
        "id": this.id,
        "iframe": this.iframe,
        "desc": this.desc
    }
