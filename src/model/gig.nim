import json
import times
import "place"

type
    Gig* = ref object of RootObj
        id: int
        date: DateTime
        place: Place

proc newGig*(id: int, date: DateTime, place: Place): Gig =
    return Gig(
        id: id,
        date: date,
        place: place
    )

proc newGig*(id: int, dt, tm: string, place: Place): Gig =
    var dtStr = dt & tm
    return Gig(
        id: id,
        date: dtStr.parse("yyyy-MM-ddHH:mm:ss"),
        place: place
    )

proc `%`*(gig: Gig): JsonNode =
    return %* {
        "id": gig.id,
        "date": gig.date.toTime().toUnix(),
        "place": gig.place
    }
