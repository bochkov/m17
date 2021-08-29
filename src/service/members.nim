import "../model/member"
import "../repo/member_repo"
import "services"

type
    Members* = ref object of Service
        memberRepo: MemberRepo

proc newMembers*(memberRepo: MemberRepo) : Members =
    return Members(memberRepo: memberRepo)

proc findAll*(this: Members): seq[Member] =
    return this.memberRepo.all()

proc findAllTime*(this: Members): seq[Member] =
    return this.memberRepo.allTime()
