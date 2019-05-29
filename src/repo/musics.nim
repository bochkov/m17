import db_postgres
import strutils
import "../model/music", "../model/muslink"

type
    Musics* = object
        db: DbConn

proc newMusics*(db: DbConn): Musics =
    return Musics(db: db)

proc linksFor(musics: Musics, id: int): seq[MusLink] =
    var query: string = """SELECT ml.id, mp.id, mp.name, ml.url
        FROM music_links ml, music_provs mp
        WHERE ml.provider = mp.id and ml.music = ?
        ORDER by mp.id"""
    var retre: seq[MusLink] = @[]
    for row in musics.db.getAllRows(sql(query), id):
        retre.add(
            newMusLink(
                row[0].parseInt(),
                row[1].parseInt(),
                row[2],
                row[3]
            )
        )
    return retre

proc all*(this: Musics): seq[Music] =
    var query: string = "SELECT * FROM music ORDER BY year DESC"
    var retre: seq[Music] = @[]
    for row in this.db.getAllRows(sql(query)):
        var id: int = row[0].parseInt()
        retre.add(
            newMusic(
                id,
                row[1],
                row[2].parseInt(),
                this.linksFor(id)
            )
        )
    return retre
