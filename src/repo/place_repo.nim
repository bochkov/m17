import "../db"
import "db_repo"

type
    PlaceRepo* = ref object of Repo

proc placeRepo*(db : Database) : PlaceRepo =
    return PlaceRepo(db: db)
