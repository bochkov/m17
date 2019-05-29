import db_postgres
import strutils
import "../model/member"

type
    Members* = object
        db: DbConn

proc newMembers*(db: DbConn): Members =
    return Members(db: db)

proc all*(this: Members): seq[Member] =
    var query = "SELECT * FROM members ORDER BY weight"
    var retre: seq[Member] = @[]
    for row in this.db.getAllRows(sql(query)):
        retre.add(
            newMember(
                row[0].parseInt(),
                row[1],
                row[2],
                row[3].parseInt()
            )
        )
    return retre
