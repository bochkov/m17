import json

type
    Member* = ref object of RootObj
        id: int
        name: string
        instrument: string
        order: int
        actual: bool

proc newMember*(id: int, name, instrument: string, order: int, actual: bool): Member =
    return Member(
        id: id,
        name: name,
        instrument: instrument,
        order: order,
        actual: actual
    )

proc `%`*(this: Member): JsonNode =
    return %* {
        "id": this.id,
        "name": this.name,
        "instrument": this.instrument,
        "order": this.order,
        "actual": this.actual
    }
