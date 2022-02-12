import db_postgres
import strutils
import "../model/music", "../model/muslink"
import "db_repo"

type
    MusicRepo* = ref object of Repo

proc musicRepo*(db: DbConn): MusicRepo =
    return MusicRepo(db: db)

## список ссылок для альбома
proc linksFor(this: MusicRepo, id: int): seq[MusLink] =
    var query: string = """SELECT ml.id, mp.id, mp.name, ml.url
        FROM music_links ml, music_provs mp
        WHERE ml.provider = mp.id and ml.music = ?
        ORDER BY mp.id, ml.id"""
    var retre: seq[MusLink] = @[]
    for row in this.db.getAllRows(sql(query), id):
        retre.add(
            newMusLink(row[0].parseInt(), row[1].parseInt(), row[2], row[3])
        )
    return retre

proc promo*(this: MusicRepo): Music =
    var query: string = """SELECT * FROM music m
        WHERE m.id = (select max(id) from music where ignore=false)"""
    var retre: seq[Music] = @[]
    for row in this.db.getAllRows(sql(query)):
        var id: int = row[0].parseInt()
        retre.add(
            newMusic(id, row[1], row[2].parseInt(), row[3].parseInt(), this.linksFor(id))
        )
    return retre[0]

proc all*(this: MusicRepo): seq[Music] =
    var query: string = "SELECT * FROM music WHERE ignore=false ORDER BY year DESC, id DESC"
    var retre: seq[Music] = @[]
    for row in this.db.getAllRows(sql(query)):
        var id: int = row[0].parseInt()
        retre.add(
            newMusic(id, row[1], row[2].parseInt(), row[3].parseInt(), this.linksFor(id))
        )
    return retre
