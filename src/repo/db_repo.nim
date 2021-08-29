import db_postgres

type
    Repo* = ref object of RootObj
        db*: DbConn