import db_postgres
import strutils

import "db_repo"
import "../model/member"
import "../util/util"

type
    MemberRepo* = ref object of Repo

proc memberRepo*(db: DbConn): MemberRepo =
    return MemberRepo(db: db)

proc all*(this: MemberRepo): seq[Member] =
    var query = """SELECT m.id, m.name, i.text, m.weight, m.actual 
        FROM members m, instrument i 
        WHERE m.instrument=i.id AND m.actual=true 
        ORDER BY weight"""
    var retre: seq[Member] = @[]
    for row in this.db.getAllRows(sql(query)):
        retre.add(
            newMember(
                row[0].parseInt(), 
                row[1], 
                row[2], 
                row[3].parseInt(), 
                row[4].parsePgBool()
            )
        )
    return retre

proc allTime*(this: MemberRepo): seq[Member] =
    var query = """SELECT m.id, m.name, i.text, m.weight, m.actual 
        FROM members m, instrument i
        WHERE m.instrument=i.id
        ORDER BY weight"""
    var retre: seq[Member] = @[]
    for row in this.db.getAllRows(sql(query)):
        retre.add(
            newMember(
                row[0].parseInt(), 
                row[1], 
                row[2], 
                row[3].parseInt(), 
                row[4].parsePgBool()
            )
        )
    return retre
