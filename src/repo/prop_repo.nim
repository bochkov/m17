import db_postgres
import "db_repo"

type
    PropRepo* = ref object of Repo

proc propRepo*(db: DbConn): PropRepo =
    return PropRepo(db: db)

proc value*(this: PropRepo, name, def: string): string =
    var query: string = "SELECT value FROM props WHERE name = ?"
    var val: string = this.db.getValue(sql(query), name)
    if val == "":
        return def
    return val
