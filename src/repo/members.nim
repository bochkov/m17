import db_postgres
import strutils
import "../model/member"

type
    Members* = object of RootObj
        db : DbConn

proc newMembers*(db : DbConn) : Members =
    return Members(db: db)

proc all*(members: Members) : seq[Member] =
    var
        retre : seq[Member] = @[]
        rows : seq[Row] = members.db.getAllRows(sql("SELECT * FROM members"))
    for row in rows:
        retre.add(
            newMember(row[0].parseInt(), row[1], row[2])
        )
    return retre
    