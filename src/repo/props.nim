import db_postgres
import "../db"

type
    Props* = object of RootObj
        db : DbPool

proc newProps*(db : DbPool) : Props =
    return Props(db: db)

proc value*(props: Props, name, def: string) : string =
    var val : string = props.db.conn
        .getValue(sql("SELECT value FROM props WHERE name = ?"), name)
    if val == "":
        return def
    return val
