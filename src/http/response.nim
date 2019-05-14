import json

type
    Response = object
        result: string

proc success*() : Response =
    return Response(result: "true")

proc fail*() : Response =
    return Response(result: "false")

proc `%`*(resp: Response): JsonNode =
    return %* {"result": resp.result }