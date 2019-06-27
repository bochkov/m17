import db_postgres
import os
import times
import strutils
import repo/[props, gigs, members, musics, places, videos, news]
import model/[gig, member, music, place, video, newsitem]

type
    DbConf* = object
        host: string
        user: string
        port: string
        passwd: string
        db: string

proc newDbConf*(host, port, user, password, database: string): DbConf =
    return DbConf(
        host: host,
        port: port,
        user: user,
        passwd: password,
        db: database
    )

proc conn(cfg: DbConf): DbConn =
    var con: DbConn = open("", cfg.user, cfg.passwd,
        "host=$1 port=$2 dbname=$3" % [cfg.host, cfg.port, cfg.db]
    )
    discard con.setEncoding("UTF-8")
    return con

proc props*(cfg: DbConf): Props =
    return newProps(cfg.conn())

proc gigs*(cfg: DbConf): Gigs =
    return newGigs(cfg.conn())

proc musics*(cfg: DbConf): Musics =
    return newMusics(cfg.conn())

proc members*(cfg: DbConf): Members =
    return newMembers(cfg.conn())

proc videos*(cfg: DbConf): Videos =
    return newVideos(cfg.conn())

proc news*(cfg: DbConf): News =
    return newNews(cfg.conn())
