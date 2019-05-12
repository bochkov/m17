import db_postgres

type 
    DbPool* = object of RootObj
        host: string
        user: string
        password: string
        database: string

proc newPool*(host, user, password, database: string) : DbPool =
    return DbPool(
        host: host,
        user: user,
        password: password,
        database: database
    )

var connection: DbConn

proc conn*(db: DbPool) : DbConn =
    if connection != nil:
        if connection.tryExec(sql"SELECT 1"):
            return connection
        else:
            connection.close()

    connection = open(db.host, db.user, db.password, db.database)
    discard connection.setEncoding("UTF-8")
    return connection