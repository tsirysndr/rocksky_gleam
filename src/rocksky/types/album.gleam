import gleam/option.{type Option}
import rocksky/types/track.{type Track}

pub type Album {
  Album(
    id: String,
    title: String,
    artist: String,
    release_date: Option(String),
    album_art: Option(String),
    year: Option(Int),
    sha256: String,
    uri: String,
    play_count: Int,
    unique_listeners: Int,
    tags: Option(List(String)),
  )
  AlbumDetails(
    album_art: Option(String),
    artist: String,
    artist_uri: Option(String),
    release_date: Option(String),
    sha256: String,
    title: String,
    uri: String,
    xata_createdat: String,
    xata_updatedat: String,
    xata_version: Int,
    year: Option(Int),
    apple_music_link: Option(String),
    spotify_link: Option(String),
    tidal_link: Option(String),
    youtube_link: Option(String),
    id: String,
    listeners: Int,
    scrobbles: Int,
    tracks: Option(List(Track)),
    tags: Option(List(String)),
  )
}
