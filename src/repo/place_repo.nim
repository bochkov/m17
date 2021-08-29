import db_postgres
import "db_repo"

type
    PlaceRepo* = ref object of Repo

proc placeRepo*(db : DbConn) : PlaceRepo =
    return PlaceRepo(db: db)
