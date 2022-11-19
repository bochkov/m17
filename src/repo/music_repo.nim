import db_postgres
import strutils
import "../db"
import "../model/music", "../model/muslink"
import "db_repo"

type
    MusicRepo* = ref object of Repo

proc musicRepo*(db: Database): MusicRepo =
    return MusicRepo(db: db)

## список ссылок для альбома
proc linksFor(this: MusicRepo, id: int): seq[MusLink] =
    var con : DbConn = this.db.connect()
    var query: string = """SELECT ml.id, mp.id, mp.name, ml.url
        FROM music_links ml, music_provs mp
        WHERE ml.provider = mp.id and ml.music = ?
        ORDER BY mp.id, ml.id"""
    var retre: seq[MusLink] = @[]
    for row in con.getAllRows(sql(query), id):
        retre.add(
            newMusLink(row[0].parseInt(), row[1].parseInt(), row[2], row[3])
        )
    con.close()
    return retre

proc promo*(this: MusicRepo): Music =
    var con : DbConn = this.db.connect()
    var query: string = """SELECT m.id, m.name, m.year, m.type, m.slug
        FROM music m
        WHERE m.id = (select max(id) from music where ignore=false)"""
    var retre: seq[Music] = @[]
    for row in con.getAllRows(sql(query)):
        var id: int = row[0].parseInt()
        retre.add(
            newMusic(id, row[1], row[2].parseInt(), row[3].parseInt(), row[4], this.linksFor(id))
        )
    con.close()
    return retre[0]

proc all*(this: MusicRepo): seq[Music] =
    var con : DbConn = this.db.connect()
    var query: string = """SELECT m.id, m.name, m.year, m.type, m.slug
        FROM music m WHERE ignore=false ORDER BY year DESC, id DESC"""
    var retre: seq[Music] = @[]
    for row in con.getAllRows(sql(query)):
        var id: int = row[0].parseInt()
        retre.add(
            newMusic(id, row[1], row[2].parseInt(), row[3].parseInt(), row[4], this.linksFor(id))
        )
    con.close()
    return retre
