import db_postgres
import strutils
import "../model/music", "../model/muslink"

type
    Musics* = object of RootObj
        db : DbConn

proc newMusics*(db : DbConn) : Musics =
    return Musics(db: db)

proc linksFor(musics: Musics, id: int) : seq[MusLink] =
    var
        retre : seq[MusLink] = @[]
        rows : seq[Row] = musics.db.getAllRows(sql("select ml.id, ml.url, mp.id, mp.name from music_links ml, music_provs mp where ml.provider = mp.id and ml.music = ? order by mp.id"), id)
    for row in rows:
        retre.add(
            newMusLink(row[0].parseInt(), row[1], row[2].parseInt(), row[3])
        )
    return retre

proc all*(musics: Musics) : seq[Music] =
    var
        retre : seq[Music] = @[]
        rows : seq[Row] = musics.db.getAllRows(sql("SELECT * FROM music ORDER BY year DESC"))
    for row in rows:
        var id: int = row[0].parseInt()
        retre.add(
            newMusic(id, row[1], row[2].parseInt(), linksFor(musics, id))
        )
    return retre
    