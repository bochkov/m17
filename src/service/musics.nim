import "../model/music"
import "../repo/music_repo"
import "services"

type
    Musics* = ref object of Service
        musicRepo: MusicRepo

proc newMusics*(musicRepo: MusicRepo) : Musics =
    return Musics(musicRepo: musicRepo)

proc findAll*(this: Musics): seq[Music] =
    return this.musicRepo.all()

proc promo*(this: Musics): Music =
    return this.musicRepo.promo()
