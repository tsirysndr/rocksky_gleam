import gleam/option.{type Option}

pub type Scrobble {
  UserScrobble(
    id: String,
    track_id: String,
    title: String,
    artist: String,
    album_artist: String,
    album_art: Option(String),
    album: String,
    handle: String,
    uri: String,
    track_uri: Option(String),
    artist_uri: Option(String),
    album_uri: Option(String),
    created_at: String,
  )
  Scrobble(
    id: String,
    artist: String,
    cover: Option(String),
    date: String,
    listeners: Int,
    sha256: String,
    tags: List(String),
    title: String,
    uri: String,
    user: String,
  )
}
