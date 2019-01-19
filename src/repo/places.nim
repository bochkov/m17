import db_postgres
import strutils
import "../model/place"

type
    Places* = object of RootObj
        db : DbConn

proc newPlaces*(db : DbConn) : Places =
    result.db = db

proc getById*(places: Places, id : int) : Place =
    var row : Row = places.db.getRow(sql("SELECT * FROM places WHERE id=?"), id)
    return newPlace(row[0].parseInt(), row[1], row[2])