import db_postgres
import strutils
import "../db"
import "db_repo"
import "../model/video"

type
    VideoRepo* = ref object of Repo

proc videoRepo*(db: Database): VideoRepo =
    return VideoRepo(db: db)

proc all*(this: VideoRepo, limit: int): seq[Video] =
    var con : DbConn = this.db.connect()
    var query: string = "SELECT * FROM video ORDER BY vorder desc LIMIT ?"
    var retre: seq[Video] = @[]
    for row in con.getAllRows(sql(query), limit):
        retre.add(
            newVideo(row[0].parseInt(), row[1], row[2])
        )
    con.close()
    return retre
