import "../model/music"
import "../repo/music_repo"
import "services"

const 
    ALBUM: int = 1
    SINGLE: int = 2

type
    Musics* = ref object of Service
        musicRepo: MusicRepo

proc newMusics*(musicRepo: MusicRepo) : Musics =
    return Musics(musicRepo: musicRepo)

proc all*(this: Musics): seq[Music] =
    return this.musicRepo.all()

proc promo*(this: Musics): Music =
    return this.musicRepo.promo()

proc typeOf(this: Musics, mType: int): seq[Music] =
    var retre: seq[Music] = @[]
    for m in this.musicRepo.all():
        if m.typeOf(mType):
            retre.add(m)
    return retre

proc albums*(this: Musics): seq[Music] =
    return this.typeOf(ALBUM)

proc singles*(this: Musics): seq[Music] =
    return this.typeOf(SINGLE)
