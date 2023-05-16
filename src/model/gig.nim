import json
import times
import "place"

type
    Gig* = ref object of RootObj
        id: int
        date: DateTime
        place: Place
        desc: string
        url: string

proc newGig*(id: int, date: DateTime, desc, url: string, place: Place): Gig =
    return Gig(
        id: id,
        date: date,
        desc: desc,
        place: place
    )

proc newGig*(id: int, dt, tm, desc, url: string, place: Place): Gig =
    var dtStr = dt & tm
    return Gig(
        id: id,
        date: dtStr.parse("yyyy-MM-ddHH:mm:ss"),
        desc: desc,
        url: url,
        place: place
    )

proc `%`*(gig: Gig): JsonNode =
    return %* {
        "id": gig.id,
        "date": gig.date.toTime().toUnix(),
        "desc": gig.desc,
        "url": gig.url,
        "place": gig.place,
    }
