import db_postgres
import strutils
import times
import "places"
import "../model/gig", "../model/place"

type
    Gigs* = object of RootObj
        db : DbConn
        places : Places

proc newGigs*(db :DbConn, places: Places) : Gigs =
    return Gigs(db : db, places: places)

proc all*(gigs : Gigs) : seq[Gig] =
    var
        retre : seq[Gig] = @[]
        rows : seq[Row] = gigs.db.getAllRows(sql("SELECT * FROM gigs"))
    for row in rows:
        retre.add(
            newGig(
                row[0].parseInt(),
                row[1],
                row[2],
                gigs.places.getById(row[3].parseInt())
            )
        )
    return retre