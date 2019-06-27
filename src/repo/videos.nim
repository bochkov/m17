import db_postgres
import strutils
import "../model/video"

type
    Videos* = object
        db: DbConn

proc newVideos*(db: DbConn): Videos =
    return Videos(db: db)

proc all*(this: Videos, limit: int = 10): seq[Video] =
    var query: string = "SELECT * FROM video ORDER BY vorder desc LIMIT ?"
    var retre: seq[Video] = @[]
    for row in this.db.getAllRows(sql(query), limit):
        retre.add(
            newVideo(row[0].parseInt(), row[1], row[2])
        )
    this.db.close()
    return retre
