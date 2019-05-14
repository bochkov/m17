import json

type
    MusLink* = object
        id: int
        provid: int
        provider: string
        url: string

proc newMusLink*(id, provid: int, provider, url: string): MusLink =
    return MusLink(
        id: id,
        provid: provid,
        provider: provider,
        url: url,
    )

proc `%`*(mus: MusLink): JsonNode =
    return %* {
        "id": mus.id,
        "url": mus.url,
        "provid": mus.provid,
        "provider": mus.provider
    }
