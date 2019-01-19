import re
import jester
import json
import strtabs
import db_postgres
import "db", "repo/gigs", "repo/places", "model/gig", "http/response"

let
    dbConn : DbConn = newConn("192.168.55.5", "m17", "m17", "m17")
    placesRepo : Places = newPlaces(dbConn)
    gigRepo : Gigs = newGigs(dbConn, placesRepo)

template jresp(content: string, contentType = "application/json") : typed =
    resp Http200, [("Access-Control-Allow-Origin", "*"),("Content-Type", contentType)], content

routes:
    options re"/*":
        resp $success()

    get "/api/v1/gigs":
        var retre = %*[]
        for gig in gigRepo.all():
            retre.add( %* gig.toJson() )
        jresp $retre