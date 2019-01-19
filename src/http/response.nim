import json

type
    Response = object of RootObj
        result: string

proc success*() : Response =
    return Response(result: "true")

proc fail*() : Response =
    return Response(result: "false")

proc newResponse*(res: string) : Response =
    return Response(result: res)

proc `$`*(resp: Response) : string =
    return $ %* { "result": resp.result }