import asyncdispatch
import httpcore
import os
import jester
import json
import strutils
import times

import "db"
import model/[gig, member, music, newsitem, video]
import repo/[gig_repo, member_repo, music_repo, news_repo, prop_repo, video_repo]
import service/[gigs, members, musics, news, props, videos]

let
    host: string = getEnv("DB_HOST")
    port: string = getEnv("DB_PORT")
    database: string = getEnv("DB_NAME")
    user: string = getEnv("DB_USER")
    password: string = getEnv("DB_PASSWORD")

proc serve(props: Props, gigs: Gigs, members: Members, 
           musics: Musics, news: News, videos: Videos) =
    routes:
        get "/api/v1/gigs/all":
            resp %*gigs.findAll()
        
        get "/api/v1/gigs":
            resp %*gigs.findAll(since = now())

        get "/api/v1/members":
            resp %*members.findAll()

        get "/api/v1/members/all":
            resp %*members.findAllTime()

        get "/api/v1/videos":
            var limit = props.valueOf("max_videos", "10").parseInt()
            resp %*videos.findAll(limit = limit)

        get "/api/v1/albums/all":
            resp %*musics.all()

        get "/api/v1/albums":
            resp %*musics.albums()

        get "/api/v1/albums/singles":
            resp %*musics.singles()

        get "/api/v1/promo":
            resp %*musics.promo()

        get "/api/v1/news":
            var limit = props.valueOf("max_news", "5").parseInt()
            resp %*news.findAll(limit = limit)

        get "/api/v1/news/@id":
            resp %*news.findOne(@"id".parseInt())

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

    # подключение к БД
    var db: Database = newDatabase(
        host, port, database, user, password
    )
    # создание репозиториев и сервисов
    let props: Props = newProps(propRepo(db))
    let gigs: Gigs = newGigs(gigRepo(db))
    let members: Members = newMembers(memberRepo(db))
    let musics: Musics = newMusics(musicRepo(db))
    let news: News = newNews(newsRepo(db))
    let videos: Videos = newVideos(videoRepo(db))
    #
    serve(props, gigs, members, musics, news, videos)
