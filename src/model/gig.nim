import times
import json
import "place"

type
    Gig* = object of RootObj
        id: int
        date: DateTime
        place: Place

proc newGig*(id: int, date: DateTime, place: Place) : Gig =
    return Gig(id: id, date: date, place: place)

proc newGig*(id: int, dt, tm: string, place: Place) : Gig =
    var date : DateTime = parse(dt & tm, "yyyy-MM-ddHH:mm:ss")
    return Gig(id: id, date: date, place: place)

proc toJson*(gig : Gig) : JsonNode =
    return %* {
        "id": gig.id,
        "date": gig.date.toTime().toUnix(),
        "place": gig.place.toJson()
    }