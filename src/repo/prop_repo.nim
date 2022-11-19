import db_postgres
import "../db"
import "db_repo"

type
    PropRepo* = ref object of Repo

proc propRepo*(db: Database): PropRepo =
    return PropRepo(db: db)

proc value*(this: PropRepo, name, def: string): string =
    var con : DbConn = this.db.connect()
    var query: string = "SELECT value FROM props WHERE name = ?"
    var val: string = con.getValue(sql(query), name)
    con.close()
    if val == "":
        return def
    return val
