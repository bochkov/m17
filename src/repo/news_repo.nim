import db_postgres
import strutils
import "../db"
import "../model/newsitem"
import "db_repo"

type
    NewsRepo* = ref object of Repo

proc newsRepo*(db: Database): NewsRepo =
    return NewsRepo(db: db)

proc all*(this: NewsRepo, limit: int): seq[NewsItem] =
    var con : DbConn = this.db.connect()
    var query: string = "SELECT * FROM news WHERE hidden=false ORDER BY dt DESC LIMIT ?"
    var retre: seq[NewsItem] = @[]
    for row in con.getAllRows(sql(query), limit):
        retre.add(
            newNewsItem(row[0].parseInt(), row[1], row[2], row[3])
        )
    con.close()
    return retre

proc get*(this: NewsRepo, id: int): NewsItem =
    var con : DbConn = this.db.connect()
    var query: string = "SELECT * FROM news WHERE id = ?"
    var retre: seq[NewsItem] = @[]
    for row in con.getAllRows(sql(query), id):
        retre.add(
            newNewsItem(row[0].parseInt(), row[1], row[2], row[3])
        )
    con.close()
    return retre[0]
