import json

type
    Member* = ref object of RootObj
        id: int
        name: string
        text: string
        order: int
        actual: bool

proc newMember*(id: int, name, text: string, order: int, actual: bool): Member =
    return Member(
        id: id,
        name: name,
        text: text,
        order: order,
        actual: actual
    )

proc `%`*(this: Member): JsonNode =
    return %* {
        "id": this.id,
        "name": this.name,
        "text": this.text,
        "order": this.order,
        "actual": this.actual
    }
