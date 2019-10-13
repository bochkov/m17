import db_postgres
import strutils
import times
import "../model/gig", "../model/place"

let DT_START: DateTime = "1982-10-16".parse("yyyy-MM-dd")

type
    Gigs* = object
        db: DbConn

proc newGigs*(db: DbConn): Gigs =
    return Gigs(db: db)

proc all*(this: Gigs, since: DateTime = DT_START): seq[Gig] =
    var query: string = """SELECT 
        g.id, g.dt, g.tm, 
        p.id, p.name, p.address, p.link 
        FROM gigs g, places p 
        WHERE g.place = p.id AND g.dt >= ?
        ORDER BY g.dt, g.tm"""
    var retre: seq[Gig] = @[]
    for row in this.db.getAllRows(sql(query), since):
        retre.add(
            newGig(
                row[0].parseInt(), row[1], row[2],
                newPlace(row[3].parseInt(), row[4], row[5], row[6])
            )
        )
    this.db.close()
    return retre
