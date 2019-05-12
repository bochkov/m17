import os
import re
import jester
import times
import json
import algorithm
import strtabs
import db_postgres
import "db"
import repo/[props,gigs,members,musics,places,videos,news]
import model/[gig,member,music,place,video,newsitem]
import "http/response"

const STATIC_DIR : string = "./public/static"

let
    host : string = getEnv("DB_HOST")
    database : string = getEnv("DB_NAME")
    user : string = getEnv("DB_USER")
    password : string = getEnv("DB_PASSWORD")

echo "M17 backend start == ", now()
echo "DB_HOST: " & host
echo "DB_NAME: " & database
echo "DB_USER: " & user
if host == "" or database == "" or user == "":
    echo "No env DB_HOST/DB_NAME/DB_USER/DB_PASSWORD"
    echo "Exiting."
    quit(5)
echo "DB_PASSWORD: ******"

let
    dbPool : DbPool = newPool(host, user, password, database)
    propsRepo : Props = newProps(dbPool)
    placesRepo : Places = newPlaces(dbPool)
    gigRepo : Gigs = newGigs(dbPool, placesRepo)
    musRepo: Musics = newMusics(dbPool)
    memRepo : Members = newMembers(dbPool)
    videoRepo : Videos = newVideos(dbPool, propsRepo)
    newsRepo : News = newNews(dbPool, propsRepo)

template jresp(content: string, contentType = "application/json") : typed =
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

    get "/api/v1/gallery":
        var
            retre : seq[string]
            galleryDir : string = STATIC_DIR & "/gallery"
        for kind, path in walkDir(galleryDir, false):
            retre.add(path[8..<path.len])
        retre.sort(system.cmp)
        jresp $(%retre)

    get "/api/v1/news":
        var retre = %*[]
        for n in newsRepo.all():
            retre.add( %* n.toJson() )
        jresp $retre