import "../db"

type
    Repo* = ref object of RootObj
        db*: Database