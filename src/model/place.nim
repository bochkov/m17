import json

type
    Place* = object of RootObj
        id: int
        name, address, link: string

proc newPlace*(id: int, name, address, link: string) : Place =
    return Place(id: id, name: name, address: address, link: link)

proc toJson*(place : Place) : JsonNode =
    return %* {
        "id": place.id,
        "name": place.name,
        "address": place.address,
        "link": place.link
    }