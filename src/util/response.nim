import json

type
    Response = ref object of RootObj
        result: string

proc success*() : Response =
    return Response(result: "true")

proc fail*() : Response =
    return Response(result: "false")

proc `%`*(resp: Response): JsonNode =
    return %* {"result": resp.result }