import json
import times

type
    NewsItem* = ref object of RootObj
        id: int
        dt: DateTime
        text: string
        title: string

proc newNewsItem*(id: int, dt, text, title: string): NewsItem =
    return NewsItem(
        id: id,
        dt: dt.parse("yyyy-MM-dd HH:mm:ss'.'ffffffzz"),
        text: text,
        title: title
    )

proc newNewsItem*(id: int, dt: DateTime, text, title: string): NewsItem =
    return NewsItem(
        id: id,
        dt: dt,
        text: text,
        title: title
    )

proc `%`*(this: NewsItem): JsonNode =
    return %* {
        "id": this.id,
        "dt": this.dt.toTime().toUnix(),
        "title": this.title,
        "text": this.text,
    }
