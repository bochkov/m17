import json
import times

type
    Member* = object
        id: int
        name: string
        text: string
        order: int

proc newMember*(id: int, name, text: string, order: int): Member =
    return Member(
        id: id,
        name: name,
        text: text,
        order: order
    )

proc `%`*(this: Member): JsonNode =
    return %* {
        "id": this.id,
        "name": this.name,
        "text": this.text,
        "order": this.order
    }
