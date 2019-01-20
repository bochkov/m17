import re
import jester
import json
import strtabs
import db_postgres
import "db"
import repo/[gigs,members,places,videos]
import model/[gig,member,place,video]
import "http/response"

let
    dbConn : DbConn = newConn("192.168.55.5", "m17", "m17", "m17")
    placesRepo : Places = newPlaces(dbConn)
    gigRepo : Gigs = newGigs(dbConn, placesRepo)
    memRepo : Members = newMembers(dbConn)
    videoRepo : Videos = newVideos(dbConn)

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

    get "/api/v1/members":
        var retre = %*[]
        for mem in memRepo.all():
            retre.add( %* mem.toJson() )
        jresp $retre

    get "/api/v1/videos":
        var retre = %*[]
        for v in videoRepo.all():
            retre.add( %* v.toJson() )
        jresp $retre
