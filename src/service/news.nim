import "../model/newsitem"
import "../repo/news_repo"
import "services"

type
    News* = ref object of Service
        newsRepo: NewsRepo

proc newNews*(newsRepo: NewsRepo) : News =
    return News(newsRepo: newsRepo)

proc findAll*(this: News, limit: int = 10): seq[NewsItem] =
    return this.newsRepo.all(limit)

proc findOne*(this: News, id: int): NewsItem =
    return this.newsRepo.get(id)
