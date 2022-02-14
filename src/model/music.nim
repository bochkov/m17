import json
import "muslink"

type
    Music* = ref object of RootObj
        id: int
        name: string
        year: int
        mType: int
        slug: string
        links: seq[MusLink]

proc newMusic*(id: int, name: string, year: int, mType: int, slug: string, links: seq[MusLink]): Music =
    return Music(
        id: id,
        name: name,
        year: year,
        mType: mType,
        slug: slug,
        links: links
    )

proc typeOf*(this: Music, mType: int): bool =
    return this.mType == mType

proc `%`*(this: Music): JsonNode =
    return %* {
        "id": this.id,
        "name": this.name,
        "type": this.mType,
        "year": this.year,
        "slug": this.slug,
        "links": this.links
    }
