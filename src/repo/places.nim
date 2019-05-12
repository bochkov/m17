import db_postgres
import "../db"
import strutils
import "../model/place"

type
    Places* = object of RootObj
        db : DbPool

proc newPlaces*(db : DbPool) : Places =
    return Places(db: db)

proc getById*(places: Places, id : int) : Place =
    var row : Row = places.db.conn
        .getRow(sql("SELECT * FROM places WHERE id=?"), id)
    return newPlace(row[0].parseInt(), row[1], row[2], row[3])