import gleam/option.{type Option}

pub type Artist {
  Artist(
    id: String,
    name: String,
    picture: Option(String),
    sha256: String,
    uri: String,
    play_count: Int,
    unique_listeners: Int,
    tags: Option(List(String)),
  )
  ArtistDetails(
    name: String,
    picture: Option(String),
    sha256: String,
    uri: String,
    xata_createdat: String,
    id: String,
    xata_updatedat: String,
    xata_version: Int,
    apple_music_link: Option(String),
    biography: Option(String),
    born: Option(String),
    born_in: Option(String),
    died: Option(String),
    spotify_link: Option(String),
    tidal_link: Option(String),
    youtube_link: Option(String),
    listeners: Int,
    scrobbles: Int,
    tags: Option(List(String)),
  )
}
