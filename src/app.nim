import algorithm
import asynchttpserver
import asyncdispatch
import db_postgres
import httpcore
import json
import os
import re
import strtabs
import strutils
import rosencrantz
import times

import "db"
import repo/[props, gigs, members, musics, places, videos, news]
import model/[gig, member, music, place, video, newsitem]
import "http/response"

const STATIC_DIR: string = "./public/static"

let
    host: string = getEnv("DB_HOST")
    port: string = getEnv("DB_PORT")
    database: string = getEnv("DB_NAME")
    user: string = getEnv("DB_USER")
    password: string = getEnv("DB_PASSWORD")

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

let ds = newDbConf(host, port, user, password, database)

let handler = get[
    pathChunk("/static")[
        dir(STATIC_DIR)
    ] ~
    pathChunk("/api/v1")[
        pathChunk("/gigs/all")[
            scopeAsync do:
                return ok( %* ds.gigs().all())
        ] ~
        pathChunk("/gigs")[
            scopeAsync do:
                return ok( %* ds.gigs().all(since = now()))
        ] ~
        pathChunk("/members")[
            scopeAsync do:
                return ok( %* ds.members().all())
        ] ~
        pathChunk("/videos")[
            scopeAsync do:
                let limit = ds.props().value("max_videos", "10").parseInt()
                return ok( %* ds.videos.all(limit = limit))
        ] ~
        pathChunk("/musics")[
            scopeAsync do:
                return ok( %* ds.musics().all())
        ] ~
        pathChunk("/gallery")[
            scopeAsync do:
                var
                    retre: seq[string]
                    galleryDir: string = STATIC_DIR & "/gallery"
                for kind, path in walkDir(galleryDir, false):
                    retre.add(path[6..<path.len])
                retre.sort(system.cmp)
                return ok( %* retre)
        ] ~
        pathChunk("/news")[
            scopeAsync do:
                var limit = ds.props().value("max_news", "5").parseInt()
                return ok( %* ds.news().all(limit = limit))
        ]
    ]
]

let server = newAsyncHttpServer()
waitFor server.serve(Port(5000), handler)
