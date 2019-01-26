import json

type
    MusLink* = object of RootObj
        id: int
        url: string
        provider: string

proc newMusLink*(id: int, url, provider: string) : MusLink =
    return MusLink(id: id, url: url, provider: provider)

proc toJson*(mus : MusLink) : JsonNode =
    return %* {
        "id": mus.id,
        "url": mus.url,
        "provider": mus.provider
    }