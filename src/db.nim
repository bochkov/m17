import db_postgres
import os
import times
import repo/[props, gigs, members, musics, places, videos, news]
import model/[gig, member, music, place, video, newsitem]

type
    DbConf* = object
        host: string
        user: string
        passwd: string
        db: string

    DbPool* = object
        cfg: DbConf
        pool: array[0..5, DbConn]

proc newDbConf*(host, user, password, database: string): DbConf =
    return DbConf(
        host: host,
        user: user,
        passwd: password,
        db: database
    )

proc newCon(cfg: DbConf): DbConn =
    var con: DbConn = open(cfg.host, cfg.user, cfg.passwd, cfg.db)
    discard con.setEncoding("UTF-8")
    return con

proc newPool*(cfg: DbConf): DbPool =
    var cons: array[0..5, DbConn]
    cons[0] = cfg.newCon()
    return DbPool(cfg: cfg, pool: cons)

proc conn(db: DbPool): DbConn =
    return db.pool[0]
    
proc props*(pool: DbPool): Props =
    return newProps(pool.conn())

proc gigs*(pool: DbPool): Gigs =
    return newGigs(pool.conn())

proc musics*(pool: DbPool): Musics =
    return newMusics(pool.conn())

proc members*(pool: DbPool): Members =
    return newMembers(pool.conn())

proc videos*(pool: DbPool): Videos =
    return newVideos(pool.conn())

proc news*(pool: DbPool): News =
    return newNews(pool.conn())
