import db_postgres
import strutils
import "../model/music", "../model/muslink"

type
    Musics* = object
        db: DbConn

proc newMusics*(db: DbConn): Musics =
    return Musics(db: db)

## список ссылок для альбома
proc linksFor(this: Musics, id: int): seq[MusLink] =
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

proc promo*(this: Musics): seq[MusLink] =
    var query: string = """SELECT id, provider, url
        FROM music_links
        ORDER BY id"""
    var retre: seq[MusLink] = @[]
    for row in this.db.getAllRows(sql(query)):
        retre.add(
            newMusLink(row[0].parseInt(), row[1].parseInt(), "", row[2])
        )
    return retre

proc all*(this: Musics): seq[Music] =
    var query: string = "SELECT * FROM music WHERE type = 1 ORDER BY year DESC"
    var retre: seq[Music] = @[]
    for row in this.db.getAllRows(sql(query)):
        var id: int = row[0].parseInt()
        retre.add(
            newMusic(id, row[1], row[2].parseInt(), this.linksFor(id))
        )
    this.db.close()
    return retre
