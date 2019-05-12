import db_postgres
import "../db"
import strutils
import "props"
import "../model/newsitem"

type
    News* = object of RootObj
        db : DbPool
        props: Props

proc newNews*(db : DbPool, props: Props) : News =
    return News(db: db, props: props)

proc all*(news: News) : seq[NewsItem] =
    var
        limit : int = news.props.value("max_news", "10").parseInt()
        retre : seq[NewsItem] = @[]
        rows : seq[Row] = news.db.conn
            .getAllRows(sql("SELECT * FROM news ORDER BY dt desc LIMIT ?"), limit)
    for row in rows:
        retre.add(
            newNewsItem(row[0].parseInt(), row[1], row[2], row[3])
        )
    return retre