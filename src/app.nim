import os
import re
import jester
import json
import strtabs
import db_postgres
import "db"
import repo/[gigs,members,places,videos]
import model/[gig,member,place,video]
import "http/response"

const
    host : string = getEnv("DB_HOST")
    database : string = getEnv("DB_NAME")
    user : string = getEnv("DB_USER")
    password : string = getEnv("DB_PASSWORD")

if host == "" or database == "" or user == "" or password == "":
    echo "No env DB_HOST/DB_NAME/DB_USER/DB_PASSWORD"
    echo "Exiting."
    quit(5)

let
    dbConn : DbConn = newConn(host, database, user, password)
    placesRepo : Places = newPlaces(dbConn)
    gigRepo : Gigs = newGigs(dbConn, placesRepo)
    memRepo : Members = newMembers(dbConn)
    videoRepo : Videos = newVideos(dbConn)

template jresp(content: string, contentType = "application/json") : typed =
    resp Http200, [("Content-Type", contentType)], content

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
