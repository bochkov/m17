import db_postgres
import strutils
import "../model/newsitem"
import "db_repo"

type
    NewsRepo* = ref object of Repo

proc newsRepo*(db: DbConn): NewsRepo =
    return NewsRepo(db: db)

proc all*(this: NewsRepo, limit: int): seq[NewsItem] =
    var query: string = "SELECT * FROM news WHERE hidden=false ORDER BY dt DESC LIMIT ?"
    var retre: seq[NewsItem] = @[]
    for row in this.db.getAllRows(sql(query), limit):
        retre.add(
            newNewsItem(row[0].parseInt(), row[1], row[2], row[3])
        )
    return retre

proc get*(this: NewsRepo, id: int): NewsItem =
    var query: string = "SELECT * FROM news WHERE id = ?"
    var retre: seq[NewsItem] = @[]
    for row in this.db.getAllRows(sql(query), id):
        retre.add(
            newNewsItem(row[0].parseInt(), row[1], row[2], row[3])
        )
    return retre[0]
