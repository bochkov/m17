import db_postgres
import strutils
import "../model/newsitem"

type
    News* = object
        db: DbConn

proc newNews*(db: DbConn): News =
    return News(db: db)

proc all*(this: News, limit: int = 10): seq[NewsItem] =
    var query: string = "SELECT * FROM news ORDER BY dt DESC LIMIT ?"
    var retre: seq[NewsItem] = @[]
    for row in this.db.getAllRows(sql(query), limit):
        retre.add(
            newNewsItem(row[0].parseInt(), row[1], row[2], row[3])
        )
    this.db.close()
    return retre
