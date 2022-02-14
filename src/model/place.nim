import json

type
    Place* = ref object of RootObj
        id: int
        name: string
        address: string
        link: string
        slug: string

proc newPlace*(id: int, name, address, link, slug: string): Place =
    return Place(
        id: id,
        name: name,
        address: address,
        link: link,
        slug: slug
    )

proc `%`*(place: Place): JsonNode =
    return %* {
        "id": place.id,
        "name": place.name,
        "address": place.address,
        "link": place.link,
        "slug": place.slug
    }
