import json
import "muslink.nim"

type
    Music* = object of RootObj
        id: int
        name: string
        year: int
        links: seq[MusLink]

proc newMusic*(id: int, name: string, year: int, links: seq[MusLink]) : Music =
    return Music(id: id, name: name, year: year, links: links)

proc toJson*(mus : Music) : JsonNode =
    var links = %* []
    for link in mus.links:
        links.add(link.toJson())
    return %* {
        "id": mus.id,
        "name": mus.name,
        "year": mus.year,
        "links": links
    }