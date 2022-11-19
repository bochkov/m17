import db_postgres
import strutils

type
    Database* = ref object of RootObj
        host: string
        port: string
        database: string
        user: string
        password: string

proc newDatabase*(host, port, database, user, password : string) : Database =
    return Database(
        host: host,
        port: port,
        database: database,
        user: user,
        password: password
    )

proc connect*(this: Database) : DbConn =
    var con: DbConn = db_postgres.open(
        "", this.user, this.password,
        "host=$1 port=$2 dbname=$3" % [this.host, this.port, this.database]
    )
    discard con.setEncoding("UTF-8")
    return con
