import json
import "muslink"

type
    Music* = object
        id: int
        name: string
        year: int
        links: seq[MusLink]

proc newMusic*(id: int, name: string, year: int, links: seq[MusLink]): Music =
    return Music(
        id: id,
        name: name,
        year: year,
        links: links
    )

proc `%`*(this: Music): JsonNode =
    return %* {
        "id": this.id,
        "name": this.name,
        "year": this.year,
        "links": this.links
    }
