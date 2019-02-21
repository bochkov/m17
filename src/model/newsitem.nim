import json
import times

type
    NewsItem* = object of RootObj
        id: int
        dt: DateTime
        text, title: string

proc newNewsItem*(id: int, dt, text, title: string) : NewsItem =
    var date : DateTime = parse(dt, "yyyy-MM-dd HH:mm:ss'.'ffffffzz")
    return NewsItem(id: id, dt: date, text: text, title: title)

proc newNewsItem*(id: int, dt: DateTime, text, title : string) : NewsItem =
    return NewsItem(id: id, dt: dt, text: text, title: title)

proc toJson*(n : NewsItem) : JsonNode =
    return %* {
        "id": n.id,
        "dt": n.dt.toTime().toUnix(),
        "title": n.title,
        "text": n.text,
    }