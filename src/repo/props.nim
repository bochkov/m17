import db_postgres

type
    Props* = object of RootObj
        db : DbConn

proc newProps*(db : DbConn) : Props =
    return Props(db: db)

proc value*(props: Props, name, def: string) : string =
    var val : string = props.db.getValue(sql("SELECT value FROM props WHERE name = ?"), name)
    if val == "":
        return def
    return val
