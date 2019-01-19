import json

type
    Place* = object of RootObj
        id: int
        name, address: string

proc newPlace*(id: int, name, address : string) : Place =
    return Place(id: id, name: name, address: address)

proc toJson*(place : Place) : JsonNode =
    return %* {
        "id": place.id,
        "name": place.name,
        "address": place.address
    }