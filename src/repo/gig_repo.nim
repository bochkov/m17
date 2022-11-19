import db_postgres
import strutils
import times
import "../db"
import "db_repo"
import "../model/gig", "../model/place"

type
    GigRepo* = ref object of Repo

proc gigRepo*(db: Database): GigRepo =
    return GigRepo(db: db)

proc all*(this: GigRepo, since: DateTime): seq[Gig] =
    var con : DbConn = this.db.connect()
    var query: string = """SELECT 
        g.id, g.dt, g.tm, g.desc,
        p.id, p.name, p.address, p.link, p.slug, p.inverted_logo::text
        FROM gigs g, places p 
        WHERE g.place = p.id AND g.dt >= ?
        ORDER BY g.dt, g.tm"""
    var retre: seq[Gig] = @[]
    for row in con.getAllRows(sql(query), since):
        retre.add(
            newGig(
                row[0].parseInt(), row[1], row[2], row[3],
                newPlace(row[4].parseInt(), row[5], row[6], row[7], row[8], row[9].parseBool()),
            )
        )
    con.close()
    return retre
