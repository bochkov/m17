import db_postgres
import strutils
import "../model/place"

type
    Places* = object
        db : DbConn

proc newPlaces*(db : DbConn) : Places =
    return Places(db: db)
