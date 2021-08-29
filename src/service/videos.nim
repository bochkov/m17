import "services"
import "../repo/video_repo"
import "../model/video"

type
    Videos* = ref object of Service
        videoRepo: VideoRepo

proc newVideos*(videoRepo: VideoRepo) : Videos =
    return Videos(videoRepo: videoRepo)

proc findAll*(this: Videos, limit: int = 10): seq[Video] =
    return this.videoRepo.all(limit)
