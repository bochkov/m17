import algorithm
import asynchttpserver
import asyncdispatch
import httpcore
import json
import os
import strutils
import jester
import times

import "db"
import repo/[props, gigs, members, musics, videos, news]
import model/[gig, member, music, video, newsitem]

const STATIC_DIR: string = "./public/static"

let
    host: string = getEnv("DB_HOST")
    port: string = getEnv("DB_PORT")
    database: string = getEnv("DB_NAME")
    user: string = getEnv("DB_USER")
    password: string = getEnv("DB_PASSWORD")

proc serve(ds: DbConf) =
    routes:
        get "/api/v1/gigs/all":
            resp %*ds.gigs().all()
        
        get "/api/v1/gigs":
            resp %*ds.gigs().all(since = now())

        get "/api/v1/members":
            resp %*ds.members.all()

        get "/api/v1/videos":
            var limit = ds.props().value("max_videos", "10").parseInt()
            var j = %* ds.videos.all(limit = limit)
            resp j

        get "/api/v1/musics":
            resp %*ds.musics().all()

        get "/api/v1/gallery":
            var
                retre: seq[string]
                galleryDir: string = STATIC_DIR & "/gallery"
            for kind, path in walkDir(galleryDir, false):
                retre.add(path[6..<path.len])
            retre.sort(system.cmp)
            resp %*retre

        get "/api/v1/news":
            var limit = ds.props().value("max_news", "5").parseInt()
            resp %*ds.news().all(limit = limit)

if isMainModule:
    echo "M17 backend start == ", now()
    echo "DB_HOST: " & host
    echo "DB_PORT: " & port
    echo "DB_NAME: " & database
    echo "DB_USER: " & user
    if host == "" or database == "" or user == "":
        echo "No env DB_HOST/DB_PORT/DB_NAME/DB_USER/DB_PASSWORD"
        echo "Exiting."
        quit(5)
    echo "DB_PASSWORD: ******"

    serve(
        newDbConf(host, port, user, password, database)
    )
