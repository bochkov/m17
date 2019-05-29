import db_postgres

type
    Props* = object
        db: DbConn

proc newProps*(db: DbConn): Props =
    return Props(db: db)

proc value*(this: Props, name, def: string): string =
    var query: string = "SELECT value FROM props WHERE name = ?"
    var val: string = this.db.getValue(sql(query), name)
    if val == "":
        return def
    return val
