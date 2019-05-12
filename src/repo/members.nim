import db_postgres
import "../db"
import strutils
import "../model/member"

type
    Members* = object of RootObj
        db : DbPool

proc newMembers*(db : DbPool) : Members =
    return Members(db: db)

proc all*(members: Members) : seq[Member] =
    var
        retre : seq[Member] = @[]
        rows : seq[Row] = members.db.conn
            .getAllRows(sql("SELECT * FROM members ORDER BY weight"))
    for row in rows:
        retre.add(
            newMember(row[0].parseInt(), row[1], row[2], row[3].parseInt())
        )
    return retre
    