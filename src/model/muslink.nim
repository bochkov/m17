import json

type
    MusLink* = object of RootObj
        id: int
        url: string
        provid: int
        provider: string

proc newMusLink*(id: int, url: string, provid: int, provider: string) : MusLink =
    return MusLink(id: id, url: url, provid: provid, provider: provider)

proc toJson*(mus : MusLink) : JsonNode =
    return %* {
        "id": mus.id,
        "url": mus.url,
        "provid": mus.provid,
        "provider": mus.provider
    }