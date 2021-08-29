import "services"
import "../repo/place_repo"

type
    Places* = ref object of Service
        placeRepo: PlaceRepo
