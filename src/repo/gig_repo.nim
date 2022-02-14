import db_postgres
import strutils
import times
import "db_repo"
import "../model/gig", "../model/place"

type
    GigRepo* = ref object of Repo

proc gigRepo*(db: DbConn): GigRepo =
    return GigRepo(db: db)

proc all*(this: GigRepo, since: DateTime): seq[Gig] =
    var query: string = """SELECT 
        g.id, g.dt, g.tm, 
        p.id, p.name, p.address, p.link, p.slug 
        FROM gigs g, places p 
        WHERE g.place = p.id AND g.dt >= ?
        ORDER BY g.dt, g.tm"""
    var retre: seq[Gig] = @[]
    for row in this.db.getAllRows(sql(query), since):
        retre.add(
            newGig(
                row[0].parseInt(), row[1], row[2],
                newPlace(row[3].parseInt(), row[4], row[5], row[6], row[7])
            )
        )
    return retre
