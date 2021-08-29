import db_postgres
import strutils
import "db_repo"
import "../model/video"

type
    VideoRepo* = ref object of Repo

proc videoRepo*(db: DbConn): VideoRepo =
    return VideoRepo(db: db)

proc all*(this: VideoRepo, limit: int): seq[Video] =
    var query: string = "SELECT * FROM video ORDER BY vorder desc LIMIT ?"
    var retre: seq[Video] = @[]
    for row in this.db.getAllRows(sql(query), limit):
        retre.add(
            newVideo(row[0].parseInt(), row[1], row[2])
        )
    return retre
