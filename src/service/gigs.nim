import times

import "../model/gig"
import "../repo/gig_repo"
import "services"

let DT_START: DateTime = "1982-10-16".parse("yyyy-MM-dd")

type
    Gigs* = ref object of Service
        gigRepo: GigRepo

proc newGigs*(gigRepo: GigRepo) : Gigs =
    return Gigs(gigRepo: gigRepo)

proc findAll*(this: Gigs, since: DateTime = DT_START): seq[Gig] =
    return this.gigRepo.all(since)
