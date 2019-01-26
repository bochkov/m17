import os
import re
import jester
import times
import json
import strtabs
import db_postgres
import "db"
import repo/[gigs,members,musics,places,videos]
import model/[gig,member,music,place,video]
import "http/response"

let
    host : string = getEnv("DB_HOST")
    database : string = getEnv("DB_NAME")
    user : string = getEnv("DB_USER")
    password : string = getEnv("DB_PASSWORD")

echo "DB_HOST: " & host
echo "DB_NAME: " & database
echo "DB_USER: " & user
var maskedPass : string
if password == "":
    maskedPass = password
else:
    maskedPass = "******"
echo "DB_PASSWORD: " & maskedPass
if host == "" or database == "" or user == "" or password == "":
    echo "No env DB_HOST/DB_NAME/DB_USER/DB_PASSWORD"
    echo "Exiting."
    quit(5)

let
    dbConn : DbConn = newConn(host, database, user, password)
    placesRepo : Places = newPlaces(dbConn)
    gigRepo : Gigs = newGigs(dbConn, placesRepo)
    musRepo: Musics = newMusics(dbConn)
    memRepo : Members = newMembers(dbConn)
    videoRepo : Videos = newVideos(dbConn)

template jresp(content: string, contentType = "application/json") : typed =
    # ("Access-Control-Allow-Origin", "*"),
    resp Http200, [("Content-Type", contentType)], content

routes:
    options re"/*":
        resp $success()

    get "/api/v1/gigs":
        var retre = %*[]
        for gig in gigRepo.allSince(now()):
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

    get "/api/v1/musics":
        var retre = %*[]
        for m in musRepo.all():
            retre.add( %* m.toJson() )
        jresp $retre