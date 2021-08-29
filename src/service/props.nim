import "services"
import "../repo/prop_repo"

type
    Props* = ref object of Service
        propRepo: PropRepo

proc newProps*(propRepo: PropRepo) : Props =
    return Props(propRepo: propRepo)

proc valueOf*(this: Props, name, def: string): string =
    return this.propRepo.value(name, def)
