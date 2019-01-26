import db_postgres
import strutils
import "../model/video"

type
    Videos* = object of RootObj
        db : DbConn

proc newVideos*(db : DbConn) : Videos =
    return Videos(db: db)

proc all*(videos: Videos) : seq[Video] =
    var
        retre : seq[Video] = @[]
        rows : seq[Row] = videos.db.getAllRows(sql("SELECT * FROM video ORDER BY vorder"))
    for row in rows:
        retre.add(
            newVideo(row[0].parseInt(), row[1], row[2])
        )
    return retre