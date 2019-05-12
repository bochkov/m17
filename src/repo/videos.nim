import db_postgres
import "../db"
import strutils
import "props"
import "../model/video"

type
    Videos* = object of RootObj
        db : DbPool
        props: Props

proc newVideos*(db : DbPool, props: Props) : Videos =
    return Videos(db: db, props: props)

proc all*(videos: Videos) : seq[Video] =
    var
        limit : int = videos.props.value("max_videos", "10").parseInt()
        retre : seq[Video] = @[]
        rows : seq[Row] = videos.db.conn
            .getAllRows(sql("SELECT * FROM video ORDER BY vorder desc LIMIT ?"), limit)
    for row in rows:
        retre.add(
            newVideo(row[0].parseInt(), row[1], row[2])
        )
    return retre