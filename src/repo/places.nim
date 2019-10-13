import db_postgres

type
    Places* = object
        db : DbConn

proc newPlaces*(db : DbConn) : Places =
    return Places(db: db)
