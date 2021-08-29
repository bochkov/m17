proc parsePgBool*(str: string) : bool =
    if str == "t":
        return true
    return false
